//
//  MSAccountManager.m
//  MoShang
//
//  Created by stonedong on 15/2/7.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSAccountManager.h"
#import <DZSingletonFactory.h>
#import <DZProgramDefines.h>
@implementation MSAccountManager

+ (MSAccountManager*) shareManager
{
    return DZSingleForClass([MSAccountManager class]);
}

INIT_DZ_EXTERN_STRING(kMSStorageAccount, MSStorageAccount);
- (MSAccount*) loadAccountFromStorage
{
    NSDictionary* dic = [[NSUserDefaults standardUserDefaults] objectForKey:kMSStorageAccount];
    if (!dic) {
        return nil;
    }
    return [[MSAccount alloc] initWithDictionary:dic error:nil];
}

- (void) storeAccountToStorage:(MSAccount*)account
{
    NSDictionary* dic = [account toDictionary];
    if (!dic) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kMSStorageAccount];
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:kMSStorageAccount];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _currentAccount = [self loadAccountFromStorage];
    return self;
}

- (void) reloadAccount:(MSAccount *)account
{
    _currentAccount = account;
    [self storeAccountToStorage:_currentAccount];
}

@end
