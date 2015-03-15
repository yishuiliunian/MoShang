//
//  MSUILogicManager.m
//  MoShang
//
//  Created by stonedong on 15/3/15.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSUILogicManager.h"
#import <DZSingletonFactory.h>

@interface MSUILogicManager () <MSUILogicDelegate>
{
    NSMutableArray* _logicProcesses;
}
@end

@implementation MSUILogicManager
 + (MSUILogicManager*) shareManager
{
    return DZSingleForClass([self class]);
}

- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _logicProcesses = [NSMutableArray new];
    return self;
}

- (void) addLogicProcess:(MSUILogicProcess*)logic
{
    if (logic) {
        logic.delegate = self;
        [_logicProcesses addObject:logic];
    }
}

- (void) logicProcess:(MSUILogicProcess *)process finishedScucceed:(BOOL)scuceed error:(NSError *)error
{
    [_logicProcesses removeObject:process];
}
@end
