//
//  MSUserInfoReq.m
//  MoShang
//
//  Created by stonedong on 15/2/10.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSUserInfoReq.h"
#import "MSUserInfo.h"
#import "MSLog.h"

@implementation MSUserInfoReq
- (NSString*) method
{
    return @"getuserinfo.php";
}

- (BOOL) loadParamters:(NSError *__autoreleasing *)error
{
    SendSuperFunctionWithError(loadParamters);
    [self addParamter:self.uid forKey:@"uid"];
    return YES;
}
- (void) onSuccess:(id)retObject
{
    NSError* error = nil;
    MSUserInfo* userInfo = [[MSUserInfo alloc] initWithDictionary:retObject error:&error];
    if (error) {
        DDLogError(@"解析用户详细信息出错:%@", error);
        [self onError:error];
        return;
    }
    [self doUIOnSuccced:userInfo];
}
@end
