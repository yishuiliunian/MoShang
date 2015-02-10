//
//  MSRequestOperation.m
//  MoShang
//
//  Created by stonedong on 15/2/7.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSRequestOperation.h"
#import "MSLog.h"

@implementation MSRequestOperation
- (instancetype) initWithRequest:(MSRequest *)request
{
    self = [super init];
    if (!self) {
        return self;
    }
    
    _request = request;
    _queueID = rand() % 10000000;
    return self;
}

- (void) main
{
    @autoreleasepool {
        DDLogInfo(@"开始进行请求%@-%d", [self.request class], self.queueID);
        BOOL ret =  [_request doRequst];
        if (!ret) {
            DDLogError(@"请求%@-%d失败 %@ : error----%@", [self.request class], self.queueID, self.request.allParamters, self.request.lastError);
        }
    }
}
@end
