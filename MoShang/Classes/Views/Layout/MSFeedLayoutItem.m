//
//  MSFeedLayoutItem.m
//  MoShang
//
//  Created by stonedong on 15/1/28.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSFeedLayoutItem.h"
#import "MSTextLayoutItem.h"
#import "MSLayoutEngine.h"
#import "MSFeed.h"


 CGFloat const MSFeedHeadImageSizeWidth = 50;
CGFloat const MSFeedMaxHeight = 140;
@interface MSFeedLayoutItem()


@end
@implementation MSFeedLayoutItem

- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _maxWidth = MSScrrenWidth();
    _backgroundLayoutItem = [MSLayoutItem new];
    self.egdeInsets = UIEdgeInsetsMake(5, 15, 5, 15);
    
    _contentWidth  = _maxWidth - self.egdeInsets.left - self.egdeInsets.right;
    _topLayoutItem = [MSLayoutItem new];
    _topLayoutItem.egdeInsets = UIEdgeInsetsMake(-10, -10, -10, -10);
    _topLayoutItem.layoutSize = CGSizeMake(_contentWidth, MSFeedHeadImageSizeWidth);
    _bottomLayoutItem = [MSLayoutItem new];
    _bottomLayoutItem.layoutSize = CGSizeMake(_contentWidth, 30);
    _bottomLayoutItem.egdeInsets = UIEdgeInsetsMake(-10, -10, -10, -10);
    
    _detailTextLayout = [[MSTextLayoutItem alloc] initWithFont:MSDefaultDetailFont() maxWidth:_contentWidth];
    return self;
}

- (void) decodeLayoutWithFeed:(MSFeed *)feed
{
        CGFloat height = 0;
        
        CGFloat(^HeightWithLayoutItem)(MSLayoutItem* item) = ^(MSLayoutItem* item) {
            CGFloat height = 0;
            height -= item.egdeInsets.top;
            height -= item.egdeInsets.bottom;
            height += item.layoutSize.height;
            return height;
        };
    
    CGFloat innerContent = _contentWidth + _topLayoutItem.egdeInsets.top + _topLayoutItem.egdeInsets.bottom;
    
        void (^SetFrameWithOrigin)(MSLayoutItem* item,  CGPoint point) = ^(MSLayoutItem* item,CGPoint point) {
            item.frame = CGRectMake(point.x, point.y , innerContent, item.layoutSize.height);
        };
        
        height += HeightWithLayoutItem(_topLayoutItem);
    
    CGPoint startPoint = CGPointZero;
    startPoint.x = -_topLayoutItem.egdeInsets.left + self.egdeInsets.left;
    startPoint.y = -_topLayoutItem.egdeInsets.top + self.egdeInsets.top;
        SetFrameWithOrigin(_topLayoutItem, startPoint);
        
        _detailTextLayout.text = feed.detailText;
        height += HeightWithLayoutItem(_detailTextLayout);
        SetFrameWithOrigin(_detailTextLayout, CGPointMake(CGRectGetMinX(_topLayoutItem.frame), CGRectGetMaxY(_topLayoutItem.frame) - _topLayoutItem.egdeInsets.bottom));
        
        height += HeightWithLayoutItem(_bottomLayoutItem);
        SetFrameWithOrigin(_bottomLayoutItem, CGPointMake(CGRectGetMinX(_topLayoutItem.frame), CGRectGetMaxY(_detailTextLayout.frame) - _detailTextLayout.egdeInsets.bottom));
        
        _layoutSize = CGSizeMake(_maxWidth, height);
    
    _backgroundLayoutItem.frame = CGRectMake(self.egdeInsets.left, self.egdeInsets.top, _contentWidth, height - self.egdeInsets.top - self.egdeInsets.bottom);
}


@end
