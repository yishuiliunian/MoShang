//
//  MSSingleFeedReq.m
//  MoShang
//
//  Created by stonedong on 15/2/7.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSSingleFeedReq.h"

@implementation MSSingleFeedReq
- (NSString*) method
{
    return @"getfeedbyid.php";
}
- (BOOL) loadParamters:(NSError *__autoreleasing *)error
{
    SendSuperFunctionWithError(loadParamters);
    [self addParamter:self.feedID forKey:@"id"];
    return YES;
}

- (void) onSuccess:(id)retObject
{
    
}
@end
