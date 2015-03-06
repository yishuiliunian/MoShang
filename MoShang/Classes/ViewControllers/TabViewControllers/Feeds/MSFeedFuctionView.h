//
//  MSFeedFuctionView.h
//  MoShang
//
//  Created by stonedong on 15/3/6.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MSLeftImageButton.h"
#import <TTTAttributedLabel.h>
#import <DZProgramDefines.h>
@interface MSFeedFuctionView : UIView
DEFINE_PROPERTY_STRONG(MSLeftImageButton*, pinglunButton);
DEFINE_PROPERTY_STRONG(MSLeftImageButton*, liaoliaoButton);
DEFINE_PROPERTY_STRONG(TTTAttributedLabel*, timeLabel);
@end
