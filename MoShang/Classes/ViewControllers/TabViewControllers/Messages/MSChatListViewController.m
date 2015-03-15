//
//  MSChatListViewController.m
//  MoShang
//
//  Created by stonedong on 15/3/6.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSChatListViewController.h"
#import <RCChatViewController.h>
@interface MSChatListViewController () <UINavigationControllerDelegate>

@end
@implementation MSChatListViewController
- (void) viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationController.delegate = self;
    self.title = @"消息";
    
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
    self.title = @"消息";
    self.tabBarItem.badgeValue = @"12";
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void) navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[RCChatViewController class]]) {
        viewController.tabBarController.tabBar.hidden = YES;
    } else if (viewController == self) {
        viewController.tabBarController.tabBar.hidden= NO;
    }
}
@end
