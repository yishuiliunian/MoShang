//
//  MSPostFeedReq.m
//  MoShang
//
//  Created by stonedong on 15/2/7.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSPostFeedReq.h"

@implementation MSPostFeedReq

- (NSString*) method
{
    return @"addafeed.php";
}


- (BOOL) loadParamters:(NSError *__autoreleasing *)error
{
    SendSuperFunctionWithError(loadParamters);
    
    [self addParamter:self.position forKey:@"pos"];
    [self addParamter:self.piclist forKey:@"piclist"];
    [self addParamter:self.backgroundColor forKey:@"background"];
    [self addParamter:self.content forKey:@"content"];
    
    return YES;
}

- (void) onSuccess:(id)retObject
{
    [self doUIOnSuccced:retObject];
}

- (void) onError:(NSError *)error
{
    [self doUIOnError:error];
}
@end
