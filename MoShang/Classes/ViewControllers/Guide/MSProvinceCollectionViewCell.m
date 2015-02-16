//
//  MSProvinceCollectionViewCell.m
//  MoShang
//
//  Created by stonedong on 15/2/15.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSProvinceCollectionViewCell.h"

@implementation MSProvinceCollectionViewCell
- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return self;
    }
    
    _badgeView = [LKBadgeView new];

    _badgeView.horizontalAlignment = LKBadgeViewHorizontalAlignmentCenter;
    [self.contentView addSubview:_badgeView];
    [self setMapSelected:NO];
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    _badgeView.frame = self.bounds;
    _badgeView.text = _badgeView.text;
}

- (void) setMapSelected:(BOOL)mapSelected
{
    _mapSelected = mapSelected;
    if (!mapSelected) {
        _badgeView.outlineColor = [UIColor lightGrayColor];
        _badgeView.backgroundColor = [UIColor whiteColor];
        _badgeView.textColor = [UIColor whiteColor];
        _badgeView.badgeColor = [UIColor lightGrayColor];
    } else
    {
        _badgeView.outlineColor = [UIColor lightGrayColor];
        _badgeView.backgroundColor = [UIColor whiteColor];
        _badgeView.textColor = [UIColor whiteColor];
        _badgeView.badgeColor = [UIColor blueColor];
    }
}
@end
