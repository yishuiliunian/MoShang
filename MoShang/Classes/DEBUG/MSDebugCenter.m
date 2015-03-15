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
#import "MSOssManager.h"
#import <DZImageCache.h>
#import "MSSingleFeedReq.h"
#import "MSAccountManager.h"
#import <PonyDebugger.h>
@interface MSDebugCenter () <MSRequestUIDelegate>

@end
@implementation MSDebugCenter
+ (MSDebugCenter*) shareCenter
{
    return DZSingleForClass([MSDebugCenter class]);
}

- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    PDDebugger *debugger = [PDDebugger defaultInstance];
    [[PDDebugger defaultInstance] connectToURL:[NSURL URLWithString:@"ws://192.168.1.100:9000/device"]];
    [debugger enableRemoteLogging];
    [debugger enableNetworkTrafficDebugging];
    [debugger enableViewHierarchyDebugging];
    return self;
}

- (void) globalTest
{
    MSSingleFeedReq* infoReq = [MSSingleFeedReq new];
    infoReq.feedID = @"50";
    
    infoReq.uidelegate = self;
    
    [MSDefaultSyncCenter performRequest:infoReq];
    
}

- (void) request:(MSRequest *)request onSucced:(id)object
{
    
}

- (void) request:(MSRequest *)request onError:(NSError *)error
{
    
}
@end
