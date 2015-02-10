//
//  MSSetUserInfoReq.m
//  MoShang
//
//  Created by stonedong on 15/2/10.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSSetUserInfoReq.h"

@implementation MSSetUserInfoReq
- (NSString*) method
{
    return @"setuserinfo.php";
}

- (BOOL) loadParamters:(NSError *__autoreleasing *)error
{
    SendSuperFunctionWithError(loadParamters);
    NSDictionary* dic = [self.userInfo toDictionary];
    NSArray* allKeys = dic.allValues;
    for (NSString* key in allKeys) {
        [self addParamter:dic[key] forKey:key];
    }
    return YES;
}

- (void) onSuccess:(id)retObject
{
    [self doUIOnError:retObject];
}
@end
