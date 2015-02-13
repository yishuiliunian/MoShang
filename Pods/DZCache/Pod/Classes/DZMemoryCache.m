//
//  DZMemoryCache.m
//  TimeUI
//
//  Created by Stone Dong on 13-12-15.
//  Copyright (c) 2013年 Stone Dong. All rights reserved.
//

#import "DZMemoryCache.h"
#import "DZSingletonFactory.h"
@implementation DZMemoryCache

+ (DZMemoryCache*) shareCache
{
    return DZSingleForClass([DZMemoryCache class]);
}

@end
