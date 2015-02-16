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
@interface MSGuideContentViewController : UINavigationController
@property (nonatomic, strong, readonly) MSUserInfo* userInfo;
@end
