//
//  MSLayoutEngine.m
//  MoShang
//
//  Created by stonedong on 15/1/27.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSLayoutEngine.h"
#import <DZSingletonFactory.h>
#import <HexColor.h>

CGFloat const MSDefaultCellSpace = 15;
CGFloat const MSDefaultCellHeightSpace = 10;
@implementation MSLayoutEngine
+ (DZSingletonFactory*) defaultEngine
{
    return DZSingleForClass([MSLayoutEngine class]);
}
@end



UIFont* MSDefaultDetailFont()
{
    static UIFont* font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        font = [UIFont systemFontOfSize:14];
    });
    return font;
}

CGFloat MSScrrenWidth()
{
    static CGFloat width;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        width = [UIScreen mainScreen].bounds.size.width;
    });
    return width;
}

HNKCacheFormat* HNKCreateCacheFormatWithSize(CGSize size, NSString* key)  {
    HNKCacheFormat* format = [HNKCache sharedCache].formats[key];
    if (!format) {
        format  = [[HNKCacheFormat alloc] initWithName:key];
        format.size = size;
        format.scaleMode = HNKScaleModeAspectFill;
        format.compressionQuality = 0.5;
        format.diskCapacity = 10*1024*1024;
        format.preloadPolicy = HNKPreloadPolicyLastSession;
        [[HNKCache sharedCache] registerFormat:format];
    }
    return format;
}

UIColor* MSDefaultBackgroundColor() {
    static UIColor* color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithHexString:@"f1f1f1"];
    });
    return color;
}
