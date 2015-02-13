//
//  DZMemoryCache.h
//  TimeUI
//
//  Created by Stone Dong on 13-12-15.
//  Copyright (c) 2013年 Stone Dong. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DZMemoryShareCache [DZMemoryCache shareCache]

@interface DZMemoryCache : NSCache

+ (DZMemoryCache*) shareCache;

@end
