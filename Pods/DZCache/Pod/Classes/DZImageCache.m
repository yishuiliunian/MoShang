//
//  DZImageCache.m
//  TimeUI
//
//  Created by Stone Dong on 13-12-15.
//  Copyright (c) 2013年 Stone Dong. All rights reserved.
//

#import "DZImageCache.h"
#import "DZMemoryCache.h"
#import "DZSingletonFactory.h"
#import "DZCDNActionManager.h"
#import "DZDevices.h"
@implementation DZImageCache

+ (DZImageCache*) shareCache
{
    return DZSingleForClass([DZImageCache class]);
}

- (UIImage*) cachedImageForName:(NSString*)name
{
    if (name == nil) {
        return nil;
    }
    UIImage* image = [DZMemoryShareCache objectForKey:name];
    if (image) {
        return image;
    }
    
    NSArray* comps = [name componentsSeparatedByString:@"."];
    NSCAssert(comps.count <= 2, @"image name error %@", name);
    NSString* fileName = nil;
    
    NSMutableArray* fileTypes = [NSMutableArray new];
    if (comps.count == 1) {
        fileName = name;
        [fileTypes addObject:@"png"];
        [fileTypes addObject:@"jpg"];
        [fileTypes addObject:@"jpeg"];
    }
    else
    {
        fileName = comps[0];
        [fileTypes addObject:comps[1]];
    }
    NSString* path = nil;
    
    
    for (NSString* type in fileTypes) {
        
        NSString*  retinaFileName = [fileName stringByAppendingString:@"@2x"];
        path = [[NSBundle mainBundle] pathForResource:retinaFileName ofType:type];
        if (path) {
            break;
        }
        
        path = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
        if (path) {
            break;
        }
    }
    
    image = [UIImage imageWithContentsOfFile:path];
    if (image) {
        [DZMemoryShareCache setObject:image forKey:path];
    }
    return image;
}

- (UIImage*) cachedImageFroPath:(NSString*)path
{
    UIImage* image = [DZMemoryShareCache objectForKey:path];
    if (!image) {
        image = [UIImage imageWithContentsOfFile:path];
        if (image) {
            [DZMemoryShareCache setObject:image forKey:path];
        }
    }
    return image;
}

- (void) cachedImageForServerURL:(NSString *)url
            placeHolderImageName:(NSString *)name
                      downloaded:(GetImageBlock)block
{
    UIImage* image = [DZMemoryShareCache objectForKey:url];
    if (image) {
        if (block) {
            block(image);
        }
    } else {
        [[DZCDNActionManager shareManager] downloadImage:url downloaded:^(UIImage *image, NSError *error) {
            if (!error && image) {
                if (block) {
                    block(image);
                    [DZMemoryShareCache setObject:image forKey:url];
                }
            } else {
                if (name) {
                    image = [self cachedImageForName:name];
                    
                    if (block) {
                        block(image);
                    }
                }

            }
        }];
    }
}

- (void) cachedImageUsingDefaultPlaceHolderForServerURL:(NSString *)url  downloaded:(GetImageBlock)block
{
    return [self cachedImageForServerURL:url placeHolderImageName:@"basketball" downloaded:block];
}

@end
