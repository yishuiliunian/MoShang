//
//  MSGuideContentViewController.h
//  MoShang
//
//  Created by stonedong on 15/2/13.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSUserInfo.h"


@class MSGuideContentViewController;
@interface UIViewController (MSGuideContentViewController)
@property (nonatomic, strong, readonly) MSGuideContentViewController* guideContentViewController;
@end

@protocol MSGuideContentDelegate <NSObject>

- (void) guideContentViewController:(MSGuideContentViewController*)guideVC finished:(BOOL)finished;

@end

@interface MSGuideContentViewController : UINavigationController
@property (nonatomic, weak) id<MSGuideContentDelegate> guideContentDelegate;
@property (nonatomic, strong, readonly) MSUserInfo* userInfo;
@end
