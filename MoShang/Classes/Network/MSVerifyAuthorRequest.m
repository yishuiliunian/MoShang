//
//  MSVerifyAuthorRequest.m
//  MoShang
//
//  Created by stonedong on 15/2/4.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSVerifyAuthorRequest.h"
#import "MSTokenManager.h"
@implementation MSVerifyAuthorRequest
- (BOOL) addCommonParamters:(NSError *__autoreleasing *)error
{
    SendSuperFunctionWithError(addCommonParamters);
    if (!ret) {
        return ret;
    }
    if (![MSShareTokenManager revarifyCacheToken:error]) {
        return NO;
    }
    
    [self addParamter:MSShareTokenString forKey:@"skey"];
    [self addParamter:MSShareToken.account forKey:@"account"];
    return YES;
}
@end
