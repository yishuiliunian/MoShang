//
//  MSBadgeContentView.m
//  MoShang
//
//  Created by stonedong on 15/3/6.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSBadgeContentView.h"
#import <LKBadgeView/LKBadgeView.h>
#import "MSBadgeItem.h"

@interface MSBadgeContentView()
{
    NSArray* _items;
}
@end
@implementation MSBadgeContentView
- (instancetype) initWithItems:(NSArray *)items
{
    self = [super init];
    if (!self) {
        return self;
    }
    _items = items;
    return self;
}
- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return self;
    }
    _multiLines = YES;
    return self;
}
- (void) setItems:(NSArray *)items
{
    if (_items != items) {
        _items = items;
        [self setNeedsLayout];
    }
}
- (void) layoutSubviews
{
    [super layoutSubviews];
    for (UIView* view in self.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat startX =5, initStartX  = 5;
    CGFloat startY = 0;

    CGFloat badgeHeight = [LKBadgeView badgeHeight] + 10;
    
    int linesCount = floor(CGRectGetHeight(self.bounds)/badgeHeight);
    BOOL canMulti = NO;
    if (linesCount > 1) {
        canMulti = YES;
    }
    canMulti = canMulti && _multiLines;
    if (!canMulti) {
        badgeHeight = CGRectGetHeight(self.bounds);
    } else {
        badgeHeight = CGRectGetHeight(self.bounds) / linesCount;
    }
    
    for (MSBadgeItem* item  in _items) {
        if (startX + item.badgeWidth + 5 > CGRectGetWidth(self.frame)) {
            startY = startY + badgeHeight;
            startX = initStartX;
            if (!canMulti) {
                break;
            }
        }
        LKBadgeView* badgeView = [[LKBadgeView alloc] initWithFrame:CGRectMake(startX, startY, item.badgeWidth , badgeHeight)];
        badgeView.horizontalAlignment = LKBadgeViewHorizontalAlignmentCenter;
        badgeView.text = item.text;
        item.font = badgeView.font;
        badgeView.textColor = [UIColor whiteColor];
        badgeView.badgeColor = [UIColor orangeColor];
        
        [self addSubview:badgeView];

        startX += item.badgeWidth + 5;
    }
}
@end
