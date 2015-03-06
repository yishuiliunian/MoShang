//
//  MSFeedDetailView.h
//  MoShang
//
//  Created by stonedong on 15/3/6.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DZProgramDefines.h>
#import "MSBadgeContentView.h"
#import "MSAvarterCollectionViewController.h"
#import <TTTAttributedLabel.h>
#import "MSFeedFuctionView.h"
@interface MSFeedDetailView : UIView
DEFINE_PROPERTY_STRONG_UIImageView(avarterImageView);
DEFINE_PROPERTY_STRONG_READONLY(MSBadgeContentView*, badgeContentView);
@property (nonatomic, strong, readonly) UILabel* nickLabel;
@property (nonatomic, strong, readonly) MSAvarterCollectionViewController* photosViewController;
@property (nonatomic, strong, readonly) MSFeedFuctionView* functionView;
@property (nonatomic, strong, readonly) UILabel* contentLabel;
- (CGFloat) estamitHeight;
@end
