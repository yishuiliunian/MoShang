//
//  MSSetLikeReq.m
//  MoShang
//
//  Created by stonedong on 15/2/10.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSSetLikeReq.h"
#import "MSGlobal.h"
@implementation MSSetLikeReq
- (NSString*) method
{
    return @"setlikeflag.php";
}

- (BOOL) loadParamters:(NSError *__autoreleasing *)error
{
    SendSuperFunctionWithError(loadParamters);
    [self addParamter:self.feedid forKey:@"feedid"];
    [self addParamter:NUM_TO_STRING(self.bLike) forKey:@"flag"];
    return YES;
}

- (void) onSuccess:(id)retObject
{
    [self doUIOnSuccced:retObject];
}
@end
