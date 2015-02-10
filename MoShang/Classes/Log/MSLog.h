//
//  MSLog.h
//  MoShang
//
//  Created by stonedong on 15/2/9.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DDLog.h>
static const DDLogLevel ddLogLevel = DDLogLevelAll;

@interface MSLog : NSObject
+ (void) setup;
@end
