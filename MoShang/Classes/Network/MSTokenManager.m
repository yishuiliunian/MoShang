//
//  MSTokenManager.m
//  MoShang
//
//  Created by stonedong on 15/2/4.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSTokenManager.h"
#import <DZSingletonFactory.h>
#import "MSAccountManager.h"
#import "MSGlobal.h"
#import "MSLoginReq.h"
@implementation MSTokenManager
+ (MSTokenManager*) shareManager {
    return DZSingleForClass([self class]);
}

- (BOOL) isTokenVaild
{
    if (!_token) {
        return NO;
    }
    if (!_token.token || !_token.account) {
        return NO;
    }
    if (!_token.experiedDate) {
        return NO;
    }
    
    if ([_token.experiedDate timeIntervalSinceNow] < 0) {
        return NO;
    }
    
    return YES;
}

- (BOOL) revarifyCacheToken:(NSError *__autoreleasing *)error
{
    if ([self isTokenVaild]) {
        return YES;
    }
    
    MSAccount* currentAccount = MSCurrentAccount;
    if (!currentAccount) {
        *error = [NSError ms_errorWithMessage:@"未登录任何账号" code:-9999];
        return NO;
    }
    
    MSLoginReq* req = [MSLoginReq new];
    req.accountID = currentAccount.accountID;
    req.password = currentAccount.password;
    if (![req doRequst]) {
        *error = req.lastError;
        return NO;
    }
    _token = [[MSToken alloc] initWithToken:req.token account:currentAccount.accountID];
    return YES;
}
@end
