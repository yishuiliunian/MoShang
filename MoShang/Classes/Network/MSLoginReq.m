//
//  MSLoginReq.m
//  MoShang
//
//  Created by stonedong on 15/2/7.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSLoginReq.h"
#import "MSAccountManager.h"

@implementation MSLoginReq

- (NSString*) method
{
    return @"login.php";
}
- (BOOL) loadParamters:(NSError *__autoreleasing *)error
{
    [self addParamter:self.accountID forKey:@"account"];
    [self addParamter:self.password forKey:@"pw"];
    return YES;
}
- (void) onSuccess:(id)retObject
{
    NSString* token = retObject[@"token"];
    _token = token;
    MSCurrentAccount.uid = retObject[@"uid"];
    [self doUIOnSuccced:token];
}
@end
