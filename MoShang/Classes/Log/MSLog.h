//
//  MSLog.h
//  MoShang
//
//  Created by stonedong on 15/2/9.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DDLog.h>
static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@interface MSLog : NSObject
+ (void) setup;
@end
