//
//  MSAlertPool.m
//  MoShang
//
//  Created by stonedong on 15/2/15.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSAlertPool.h"
#import <DZSingletonFactory.h>
#import <SCLAlertView.h>
@interface MSAlertPool ()
{
    SCLAlertView* _currentAlert;
}
@end
@implementation MSAlertPool
+ (MSAlertPool*) defaultPool
{
    return DZSingleForClass([self class]);
}

- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    
    return self;
}

- (void) hideAllAlert
{
    if (_currentAlert) {
        [_currentAlert hideView];
    }
}
- (void) showLoadingWithMessage:(NSString*)msg
{
    [self hideAllAlert];
    SCLAlertView* alert = [SCLAlertView new];
    [alert showWaiting:[UIApplication sharedApplication].keyWindow.rootViewController title:nil subTitle:msg closeButtonTitle:nil duration:100];
    _currentAlert = alert;
    
}
@end
