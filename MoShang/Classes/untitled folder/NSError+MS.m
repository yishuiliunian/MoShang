//
//  NSError+MS.m
//  MoShang
//
//  Created by stonedong on 15/2/7.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "NSError+MS.h"

static NSString* const kMSErrorDomain = @"com.moshang";
@implementation NSError (MS)

+ (NSError*) ms_errorWithMessage:(NSString*)message code:(int)code
{
    NSDictionary* userInfo = @{NSLocalizedDescriptionKey:message?message:@"未知错误"};
    return [NSError errorWithDomain:kMSErrorDomain code:code userInfo:userInfo];
}
@end
