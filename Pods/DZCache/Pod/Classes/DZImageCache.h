//
//  DZImageCache.h
//  TimeUI
//
//  Created by Stone Dong on 13-12-15.
//  Copyright (c) 2013年 Stone Dong. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DZImageShareCache [DZImageCache shareCache]

#define DZCachedImageByName(name) [DZImageShareCache cachedImageForName:(name)]
#define DZCachedImageByPath(path) [DZImageShareCache cachedImageFroPath:(path)]


typedef void(^GetImageBlock)(UIImage*image);

@interface DZImageCache : NSObject
+ (DZImageCache*) shareCache;
- (UIImage*) cachedImageForName:(NSString*)name;
- (UIImage*) cachedImageFroPath:(NSString*)path;
- (void) cachedImageForServerURL:(NSString*)url
            placeHolderImageName:(NSString*)name
                      downloaded:(GetImageBlock)block;
- (void) cachedImageUsingDefaultPlaceHolderForServerURL:(NSString *)url
                                             downloaded:(GetImageBlock)block;
@end
