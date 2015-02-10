//
//  MSReportPosReq.m
//  MoShang
//
//  Created by stonedong on 15/2/10.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSReportPosReq.h"
#import "MSLocationManager.h"

@implementation MSReportPosReq
- (NSString*) method
{
    return @"uploadpos.php";
}

- (BOOL) loadParamters:(NSError *__autoreleasing *)error
{
    SendSuperFunctionWithError(loadParamters)
    MSLocation* location = [[MSLocationManager shareManager] currentLocation];
    [self addParamter:location.serverEncodeString forKey:@"pos"];
    return YES;
}

- (void) onSuccess:(id)retObject
{
    [self doUIOnSuccced:retObject];
}
@end
