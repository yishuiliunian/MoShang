//
//  MSGetFeedByUidReq.m
//  MoShang
//
//  Created by stonedong on 15/2/10.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSGetFeedByUidReq.h"
#import "MSGlobal.h"
#import "MSFeed.h"
#import "MSLog.h"
@implementation MSGetFeedByUidReq
- (NSString*) method
{
    return @"getfeedsbyuid.php";
}

- (BOOL) loadParamters:(NSError *__autoreleasing *)error
{
    SendSuperFunctionWithError(loadParamters)
    
    [self addParamter:self.uid forKey:@"uid"];
    [self addParamter:MSCurrentTimeStapmStr() forKey:@"ts"];
    [self addParamter:@"1" forKey:@"d"];
    return YES;
}

- (void) onSuccess:(id)retObject
{
    if ([retObject isKindOfClass:[NSDictionary class]]) {
        NSArray* feeds = [retObject allValues];
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
@end
