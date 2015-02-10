//
//  MSToken.m
//  MoShang
//
//  Created by stonedong on 15/2/1.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSToken.h"

@implementation MSToken
- (instancetype) initWithToken:(NSString *)token account:(NSString *)account
{
    self = [super init];
    if (!self) {
        return self;
    }
    _token = token;
    _account = account;
    _experiedDate = [NSDate dateWithTimeIntervalSinceNow:60*10];
    return self;
}
@end
