//
//  MCSessionManager.m
//  MoShang
//
//  Created by stonedong on 15/2/2.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MCSessionManager.h"

@implementation MCSessionManager
+ (MCSessionManager*) shareManager
{
    static MCSessionManager* share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[MCSessionManager alloc] init];
    });
    return share;
}


@end
