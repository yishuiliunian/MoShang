//
//  MSRCTokenReq.m
//  MoShang
//
//  Created by stonedong on 15/3/15.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSRCTokenReq.h"

@implementation MSRCTokenReq
- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _forced = NO;
    return self;
}
- (NSString*) method
{
    return @"gettalktokenbyuid.php";
}
- (BOOL) loadParamters:(NSError *__autoreleasing *)error
{
    SendSuperFunctionWithError(loadParamters);
    [self addParamter:self.uid forKey:@"uid"];
    [self addParamter:[@(self.forced) stringValue] forKey:@"force"];
    return YES;
}

- (void) onError:(NSError *)error
{
    [super onError:error];
}

- (void) onSuccess:(id)retObject
{
    [self doUIOnSuccced:retObject[@"talktoken"]];
}
@end
