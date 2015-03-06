//
//  MSFeedDetailView.m
//  MoShang
//
//  Created by stonedong on 15/3/6.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSFeedDetailView.h"
#import "MSBadgeContentView.h"
#import <DZProgramDefines.h>
@interface MSFeedDetailView()
@end
@implementation MSFeedDetailView
- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return self;
    }
    INIT_SELF_SUBVIEW(MSBadgeContentView, _badgeContentView);
    INIT_SELF_SUBVIEW_UILabel(_nickLabel);
    INIT_SELF_SUBVIEW_UIImageView(_avarterImageView);
    INIT_SELF_SUBVIEW(TTTAttributedLabel, _addressLabel);
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    _badgeContentView.frame = self.bounds;
}
@end
