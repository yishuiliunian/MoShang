//
//  MSUserInfoProvider.m
//  MoShang
//
//  Created by stonedong on 15/3/15.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSUserInfoProvider.h"
#import <RCIM.h>
#import <DZSingletonFactory.h>
#import "MSUserInfo.h"
#import "MSRCUserInfo.h"
#import "MSGlobal.h"
@interface MSUserInfoProvider () 
@end
@implementation MSUserInfoProvider
+ (MSUserInfoProvider*) shareProvider
{
    return DZSingleForClass([self class]);
}

- (void) getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion
{
    if ([userId isEqualToString:MSCurrentAccount.uid]) {
        if (completion) {
            completion( [[RCUserInfo alloc] initWithUserId:userId name:@"我" portrait:@"https://www.baidu.com/img/bdlogo.png"]);
        }
        return;
    }
    MSRCUserInfo* userInfo = [MSRCUserInfo objectForPrimaryKey:userId];
    RCUserInfo* info = nil;
    if (userInfo) {
       info = [[RCUserInfo alloc] initWithUserId:userInfo.userId name:userInfo.nickName portrait:userInfo.avatarURL];
    } else {
        info = [[RCUserInfo alloc] initWithUserId:userId name:@"小伙伴" portrait:@"https://www.baidu.com/img/bdlogo.png"];
    }
    if (completion) {
        completion(info);
    }
    
}

- (void) cacheUserID:(NSString*)uid  nickName:(NSString*)nickName  avatar:(NSString*)url
{
    MSRCUserInfo* info = [MSRCUserInfo new];
    info.userId = uid;
    info.nickName = nickName;
    info.avatarURL = url;
   
    if (![info checkValid]) {
        return;
    }
    MSRLMBeginWrite
    [MSRLMDefaultStore addOrUpdateObject:info];
    MSRLMCommitWrite
}

@end
