//
//  MSSyncCenter.m
//  MoShang
//
//  Created by stonedong on 15/2/7.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSSyncCenter.h"
#import <DZSingletonFactory.h>
#import "MSRequest.h"
#import "MSRequestOperation.h"
#import "MSLog.h"
@interface MSSyncCenter ()
{
    NSOperationQueue* _operationQueue;
}
@end
@implementation MSSyncCenter
+ (MSSyncCenter*) defaultCenter
{
    return DZSingleForClass([self class]);
}

- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _operationQueue = [[NSOperationQueue alloc] init];
    return self;
}
- (int) performRequest:(MSRequest*)request
{
    MSRequestOperation* operation = [[MSRequestOperation alloc] initWithRequest:request];
    [_operationQueue addOperation:operation];
    return operation.queueID;
}
@end
