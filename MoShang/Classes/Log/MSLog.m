//
//  MSLog.m
//  MoShang
//
//  Created by stonedong on 15/2/9.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSLog.h"
#import <CocoaLumberjack/DDLog.h>
#import <DDTTYLogger.h>
#import <DDASLLogger.h>
#import <DDFileLogger.h>

@implementation MSLog
+ (void) setup
{
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    DDFileLogger* fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
}
@end
