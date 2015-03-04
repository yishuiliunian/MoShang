//
//  AppConfig.h
//  MoShang
//
//  Created by stonedong on 15/3/3.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#define AppDefaultConfig [AppConfig shareInstance]
@interface AppConfig : NSObject
+ (AppConfig*) shareInstance;
- (void) setup;
@end
