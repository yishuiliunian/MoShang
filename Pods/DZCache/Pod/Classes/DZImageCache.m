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
    NSArray* comps = [name componentsSeparatedByString:@"."];
    NSCAssert(comps.count <= 2, @"image name error %@", name);
    NSString* fileName = nil;
    NSString* fileType = nil;
    if (comps.count == 1) {
        fileName = name;
        fileType = @"png";
    }
    else
    {
        fileName = comps[0];
        fileType = comps[1];
    }
    NSString* path = nil;
    if (DeviceScreenISRetain()) {
        NSString* retainFileName = [fileName stringByAppendingString:@"@2x"];
        path = [[NSBundle mainBundle] pathForResource:retainFileName ofType:fileType];
        if (!path) {
            path = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
        }
    } else {
        path = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
    }
    return [self cachedImageFroPath:path];
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
