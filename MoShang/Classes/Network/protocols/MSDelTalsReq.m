//
//  MSDelTalsReq.m
//  MoShang
//
//  Created by stonedong on 15/2/10.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSDelTalsReq.h"

@implementation MSDelTalsReq
- (NSString*) method
{
    return @"eletetalkbyid.php";
}

- (BOOL) loadParamters:(NSError *__autoreleasing *)error
{
    SendSuperFunctionWithError(loadParamters)
    [self addParamter:self.tid forKey:@"tid"];
    return YES;
}

- (void) onSuccess:(id)retObject
{
    [self doUIOnSuccced:retObject];
}
@end
