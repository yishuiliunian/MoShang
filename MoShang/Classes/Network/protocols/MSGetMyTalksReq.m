//
//  MSGetMyTalksReq.m
//  MoShang
//
//  Created by stonedong on 15/2/10.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSGetMyTalksReq.h"

@implementation MSGetMyTalksReq
- (NSString*) method
{
    return @"getmytalks.php";
}

- (BOOL) loadParamters:(NSError *__autoreleasing *)error
{
    SendSuperFunctionWithError(loadParamters)
    
    return YES;
}

- (void) onSuccess:(id)retObject
{
    [self doUIOnSuccced:retObject];
}
@end
