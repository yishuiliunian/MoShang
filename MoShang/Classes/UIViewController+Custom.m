//
//  UIViewController+Custom.m
//  MoShang
//
//  Created by stonedong on 15/3/4.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "UIViewController+Custom.h"

@implementation UIViewController (Custom)
- (void) loadLeftBarItemWithTitle:(NSString*)title action:(SEL)action
{
   UIBarButtonItem* barItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
    self.navigationItem.leftBarButtonItem = barItem;
}

- (void) loadRightBarItemWithTitle:(NSString*)title action:(SEL)action
{
    UIBarButtonItem* barItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
    self.navigationItem.rightBarButtonItem = barItem;
}

@end
