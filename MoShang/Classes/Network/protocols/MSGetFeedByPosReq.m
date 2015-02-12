//
//  MSGetFeedByPosReq.m
//  MoShang
//
//  Created by stonedong on 15/2/9.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSGetFeedByPosReq.h"
#import "MSLocationManager.h"
#import "MSFeed.h"
#import "MSLog.h"
@implementation MSGetFeedByPosReq
- (NSString*) method
{
    return @"getfeedsbypos.php";
}

- (BOOL) loadParamters:(NSError *__autoreleasing *)error
{
    SendSuperFunctionWithError(loadParamters);
    MSLocation* location = [[MSLocationManager shareManager] currentLocation];
    [self addParamter:location.serverEncodeString forKey:@"pos"];
    return YES;
}

- (void) onSuccess:(id)retObject
{
    if ([retObject isKindOfClass:[NSArray class]]) {
        NSArray* feeds = retObject;
        NSMutableArray* decodeFeeds = [NSMutableArray new];
        for (NSDictionary* dic  in feeds) {
            NSError* error;
            MSFeed* f = [[MSFeed alloc] initWithDictionary:dic error:&error];
            if (!f) {
                DDLogError(@"%@",error);
                continue;
            }
            f.layoutItem = [MSFeedLayoutItem new];
            [f.layoutItem decodeLayoutWithFeed:f];
            [decodeFeeds addObject:f];
        }
        [self doUIOnSuccced:decodeFeeds];
    }
}

- (void) onError:(NSError *)error
{
    DDLogError(@"%@",error);
}
@end
