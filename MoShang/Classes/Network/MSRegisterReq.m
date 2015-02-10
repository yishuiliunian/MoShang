//
//  MSRegisterReq.m
//  MoShang
//
//  Created by stonedong on 15/2/4.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSRegisterReq.h"
#import "MSTokenManager.h"
@implementation MSRegisterReq
- (NSString*) method
{
    return @"register.php";
}
- (BOOL) loadParamters:(NSError *__autoreleasing *)error
{
    [self addParamter:self.password forKey:@"pw"];
    [self addParamter:self.accountName forKey:@"account"];
    [self addParamter:self.email forKey:@"email"];
    [self addParamter:self.phoneNumber forKey:@"mobile"];
    return YES;
}

- (void) onSuccess:(id)retObject
{
    NSString* token = retObject[@"token"];
    MSShareTokenManager.token = [[MSToken alloc] initWithToken:token account:self.accountName];
    [self doUIOnSuccced:token];
}

@end
