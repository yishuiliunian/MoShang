//
//  MSTabBarItem.m
//  MoShang
//
//  Created by stonedong on 15/1/23.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSTabBarItem.h"
#import <LKBadgeView.h>
@interface MSTabBarItem()

@end
@implementation MSTabBarItem

- (instancetype) initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    self = [super initWithTitle:title image:image selectedImage:selectedImage];
    if (!self) {
        return self;
    }
    return self;
}
- (void) setUnreadCount:(int)unreadCount
{
    _unreadCount = unreadCount;
}
@end
