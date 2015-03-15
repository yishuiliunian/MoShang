//
//  MSRCUserInfo.m
//  MoShang
//
//  Created by stonedong on 15/3/15.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSRCUserInfo.h"

@implementation MSRCUserInfo

 + (NSString*) primaryKey
{
    return @"userId";
}
 + (NSDictionary*) defaultPropertyValues
{
    return @{@"userId":@"",
             @"nickName":@"",
             @"avatarURL":@""};
}
- (BOOL) checkValid
{
    if (!self.userId) {
        return NO;
    }
    if (!self.nickName) {
        return NO;
    }
    if (!self.avatarURL) {
        return NO;
    }
    
    return YES;
}
@end
