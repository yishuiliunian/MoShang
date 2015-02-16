//
//  MSRegisterReq.m
//  MoShang
//
//  Created by stonedong on 15/2/4.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSRegisterReq.h"
#import "MSTokenManager.h"
#import <CocoaSecurity.h>
@interface MSRegisterReq ()
{
}
@end
@implementation MSRegisterReq

- (void) setPassword:(NSString *)password
{
    if (_password != password) {
        _password = password;
        _passwordMD5 = [CocoaSecurity md5:_password].hexLower;
    }
}
- (NSString*) method
{
    return @"register.php";
}
- (BOOL) loadParamters:(NSError *__autoreleasing *)error
{
    if (!self.email) {
       self.email = @"example@example.com";
    }
    [self addParamter:self.passwordMD5 forKey:@"pw"];
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
