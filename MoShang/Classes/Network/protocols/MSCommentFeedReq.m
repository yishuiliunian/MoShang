//
//  MSCommentFeedReq.m
//  MoShang
//
//  Created by stonedong on 15/2/10.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSCommentFeedReq.h"

@implementation MSCommentFeedReq
- (NSString*) method
{
    return @"addatalkbyfeed.php";
}

- (BOOL) loadParamters:(NSError *__autoreleasing *)error
{
    SendSuperFunctionWithError(loadParamters);
    [self addParamter:self.feedid forKey:@"feedid"];
    [self addParamter:self.talkid forKey:@"linkid"];
    return YES;
}

- (void) onSuccess:(id)retObject
{
    [self doUIOnSuccced:retObject];
}
@end
