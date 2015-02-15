//
//  MSTipsPool.m
//  MoShang
//
//  Created by stonedong on 15/2/15.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSTipsPool.h"
#import <DZSingletonFactory.h>
#import <RKDropdownAlert.h>
@interface MSTipsPool ()
{
    UIColor* _errorColor;
    UIColor* _successColor;
}
@end
@implementation MSTipsPool
+ (MSTipsPool*) defaultPool
{
    return DZSingleForClass([self class]);
}

- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    
    _errorColor = [UIColor redColor];
    _successColor = [UIColor greenColor];
    
    return self;
}

- (void) showError:(NSError*)error
{
    [RKDropdownAlert title:@"出错啦" message:error.localizedDescription backgroundColor:_errorColor textColor:[UIColor whiteColor]];
}

@end
