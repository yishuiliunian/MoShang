//
//  MSMainViewController.h
//  MoShang
//
//  Created by stonedong on 15/1/23.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "RDVTabBarController.h"
@class MSMainViewController;
@protocol MSMainViewControllerDelegate
- (void) mainViewControllerDidTapCenterButton:(MSMainViewController*)mainVC ;
@end
@interface MSMainViewController : UITabBarController
@property (nonatomic, weak) NSObject<MSMainViewControllerDelegate>* centerDelegate;
@end
