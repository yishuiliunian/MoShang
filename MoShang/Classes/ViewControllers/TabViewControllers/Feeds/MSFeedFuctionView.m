//
//  MSFeedFuctionView.m
//  MoShang
//
//  Created by stonedong on 15/3/6.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSFeedFuctionView.h"
#import <HexColor.h>
#import <DZImageCache.h>
@implementation MSFeedFuctionView
- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return self;
    }
    INIT_SUBVIEW(self, TTTAttributedLabel, _timeLabel);
    INIT_SUBVIEW(self, MSLeftImageButton, _liaoliaoButton);
    INIT_SUBVIEW(self, MSLeftImageButton, _pinglunButton);
    
    [_pinglunButton setTitle:@"199" forState:UIControlStateNormal];
    [_liaoliaoButton setTitle:@"聊聊" forState:UIControlStateNormal];
    
    void(^DecorateButton)(UIButton* btn, NSString* imgeName, NSString* clickImageName) = ^(UIButton* btn ,NSString* imgeName, NSString* clickImageName) {
        [btn setImage:DZCachedImageByName(imgeName) forState:UIControlStateNormal];
        [btn setImage:DZCachedImageByName(clickImageName) forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor colorWithHexString:@"499df2"] forState:UIControlStateNormal];
    };
    
    DecorateButton(_liaoliaoButton, @"liaoliao_normal", @"liaoliao_click");
    
    DecorateButton(_pinglunButton, @"zan_normal", @"zan_click");
    
    //
    

    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    CGRect functionsRect = self.bounds;
    CGSize buttonSize = CGSizeMake(70, 15);
    
    CGFloat buttonStartY = CGRectGetMinY(functionsRect) + (CGRectGetHeight(functionsRect) - buttonSize.height)/2;
    _pinglunButton.frame = CGRectMake(CGRectGetMaxX(functionsRect) - buttonSize.width - 10, buttonStartY, buttonSize.width, buttonSize.height);
    _liaoliaoButton.frame = CGRectMake(CGRectGetMinX(_pinglunButton.frame) - buttonSize.width - 10, buttonStartY, buttonSize.width, buttonSize.height);
    _timeLabel.frame = CGRectMake(CGRectGetMinX(functionsRect) + 10, buttonStartY, CGRectGetWidth(functionsRect) - 10 - CGRectGetMinX(_liaoliaoButton.frame) - 5, buttonSize.height);
}
@end
