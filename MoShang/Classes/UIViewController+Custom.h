//
//  UIViewController+Custom.h
//  MoShang
//
//  Created by stonedong on 15/3/4.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Custom)
- (void) loadLeftBarItemWithTitle:(NSString*)title action:(SEL)action;
- (void) loadRightBarItemWithTitle:(NSString*)title action:(SEL)action;
@end
