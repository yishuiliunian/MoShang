//
//  AppConfig.m
//  MoShang
//
//  Created by stonedong on 15/3/3.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "AppConfig.h"
#import <DZSingletonFactory.h>
#import "OSSClient.h"
#import "OSSTool.h"
#import "MSOssManager.h"
#import "MSAppearenceManager.h"
#import "MSDebugCenter.h"
#import <RongCloudIMKit/RCIM.h>
@implementation AppConfig
+ (AppConfig*) shareInstance
{
    return DZSingleForClass([self class]);
}
- (void) aliyunSetup
{
    OSSClient *ossclient = [OSSClient sharedInstanceManage];
    NSString *accessKey = kDZOssAceessKey; // 实际使用中，AK/SK不应明文保存在代码中
    NSString *secretKey = kDZOssScretKey;
    [ossclient setGenerateToken:^(NSString *method, NSString *md5, NSString *type, NSString *date, NSString *xoss, NSString *resource){
        NSString *signature = nil;
        NSString *content = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@%@", method, md5, type, date, xoss, resource];
        signature = [OSSTool calBase64Sha1WithData:content withKey:secretKey];
        signature = [NSString stringWithFormat:@"OSS %@:%@", accessKey, signature];
        NSLog(@"signature:%@", signature);
        return signature;
    }];
    
    [ossclient setGlobalDefaultBucketHostId:@"oss-cn-beijing.aliyuncs.com"];
}

- (void) uisetup
{
    [[MSAppearenceManager shareManager] loadGlobalAppearence];
}

- (void) rongYunIMSetup
{
    [RCIM initWithAppKey:@"3argexb6rnvue" deviceToken:nil];
    
    [RCIM connectWithToken:@"WnaRW7U4gk3YSfQdvROPDwdLTz8G4yI3awWnw14VYT5GfR7+XwA0C6Om7aEMAPz5xVIcxRP5mhpuHkZIG9OR0OABlCi9FnOS" completion:^(NSString *userId) {
        
        NSLog(@"%@",userId);
    } error:^(RCConnectErrorCode status) {
        
    }];
}

- (void) setup
{
    [self aliyunSetup];
    [self uisetup];
    [self rongYunIMSetup];
    [[MSDebugCenter shareCenter] globalTest];
}
@end