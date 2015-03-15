//
//  MSUILogicManager.h
//  MoShang
//
//  Created by stonedong on 15/3/15.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSUILogicProcess.h"
@interface MSUILogicManager : NSObject
+ (MSUILogicManager*) shareManager;
- (void) addLogicProcess:(MSUILogicProcess*)logic;
@end
