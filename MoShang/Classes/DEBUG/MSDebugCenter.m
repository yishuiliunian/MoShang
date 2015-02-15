//
//  MSDebugCenter.m
//  MoShang
//
//  Created by stonedong on 15/2/7.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSDebugCenter.h"
#import <DZSingletonFactory.h>
#import "MSPostFeedReq.h"
#import "MSSyncCenter.h"
#import "MSLocationManager.h"
#import "MSGetFeedByPosReq.h"
#import "MSUserInfoReq.h"

@implementation MSDebugCenter
+ (MSDebugCenter*) shareCenter
{
    return DZSingleForClass([MSDebugCenter class]);
}

- (void) globalTest
{
    MSUserInfoReq* infoReq = [MSUserInfoReq new];
    
//    [MSDefaultSyncCenter performRequest:infoReq];
}
@end
