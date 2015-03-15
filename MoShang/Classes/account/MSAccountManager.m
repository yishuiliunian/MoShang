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
#import "MSRCTokenReq.h"
#import <RongCloudIMKit/RCIM.h>

@interface MSAccountManager () <MSRequestUIDelegate>
@property (nonatomic, assign) int reloadTokenCount;
@end
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
    _reloadTokenCount = 0;
    _currentAccount = [self loadAccountFromStorage];
    return self;
}

- (void) reloadAccount:(MSAccount *)account
{
    _currentAccount = account;
    if (_currentAccount) {
        [self reloadRongCloudToken:NO];
    }
    [self storeAccountToStorage:_currentAccount];
}

- (void) reloadRongCloudToken:(BOOL)force
{
    if (_currentAccount == nil) {
        return;
    }
    
    MSRCTokenReq* req = [MSRCTokenReq new];
    req.uid = _currentAccount.uid;
    req.uidelegate = self;
    req.forced = force;
    [MSDefaultSyncCenter performRequest:req];
}

- (void) request:(MSRequest *)request onError:(NSError *)error
{
    
}

- (void) request:(MSRequest *)request onSucced:(id)object
{
    NSString* token = object;
    [RCIM connectWithToken:token completion:^(NSString *userId) {
        
        NSLog(@"%@",userId);
    } error:^(RCConnectErrorCode status) {
    
        if (status == ConnectErrorCode_TOKEN_INCORRECT) {
            if (_reloadTokenCount < 2) {
                [self reloadRongCloudToken:YES];
                _reloadTokenCount ++;
            }
        }
    }];
}
@end
