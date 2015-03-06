//
//  MSGetSingleFeedTalksReq.m
//  MoShang
//
//  Created by stonedong on 15/3/6.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSGetSingleFeedTalksReq.h"

@implementation MSGetSingleFeedTalksReq
- (NSString*) method
{
    return @"getfeedtalksbyid.php";
}

- (BOOL) loadParamters:(NSError *__autoreleasing *)error
{
    SendSuperFunctionWithError(loadParamters);
    [self addParamter:self.feedID forKey:@"recordid"];
    return YES;
}
- (void) onSuccess:(id)retObject
{
    [self doUIOnSuccced:retObject];
}
@end
