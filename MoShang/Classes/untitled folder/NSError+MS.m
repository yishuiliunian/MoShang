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


NSString* ServerErrorMessageWithCode(int code)
{
    static NSMutableDictionary* dic = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dic = [NSMutableDictionary new];
        [dic setObject:@"超频" forKey:@1];
        dic[@-1] = @"登录态过期";
        dic[@-2] = @"未知错误";
        dic[@-3] = @"未登录";
        dic[@-4] = @"缺少参数";
        dic[@-5] = @"无效的记录";
        
#define AddErrorMsg(code, msg) dic[@code] = @""#msg;
        AddErrorMsg(-6, 参数错误)
        AddErrorMsg(-7, 账户已存在)
        AddErrorMsg(-8, 已经针对该feed发起过会话)
        AddErrorMsg(-9, 能针对自己操作)
        AddErrorMsg(-10, 必须针对自己操作)
        AddErrorMsg(-11, 低于最低可用版本)
        AddErrorMsg(-99, 系统mysql错误)
    });
    return dic[@(code)];
}
