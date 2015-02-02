//
//  MSMainViewController.m
//  MoShang
//
//  Created by stonedong on 15/1/23.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSMainViewController.h"
#import <DZProgramDefines.h>
#import "MSMainViewController.h"
#import "MSCenterAddButton.h"
#import <DZImageCache.h>
@interface MSMainViewController ()
DEFINE_PROPERTY_STRONG(MSCenterAddButton*, centerButton);
DEFINE_PROPERTY_ASSIGN_INT16(insertIndex);
@end

@implementation MSMainViewController

- (void) initViewControllers
{
    
}
- (void) viewDidLoad
{
    [super viewDidLoad];
    INIT_SUBVIEW(self.tabBar, MSCenterAddButton, _centerButton);
    
    [_centerButton addTarget:self action:@selector(didTapCenterButton:) forControlEvents:UIControlEventTouchUpInside];
}


- (void) didTapCenterButton:(UIButton*)button
{
    if ([self.centerDelegate respondsToSelector:@selector(mainViewControllerDidTapCenterButton:)]) {
        [self.centerDelegate mainViewControllerDidTapCenterButton:self];
    }
}

- (void) setViewControllers:(NSArray *)viewControllers
{
    NSAssert(viewControllers.count > 0, @"viewControllers count big than 0");
    NSMutableArray* modifiedVCs = [viewControllers mutableCopy];
    
    _insertIndex = ceil( modifiedVCs.count/2);
    if (_insertIndex < modifiedVCs.count) {
        UIViewController* viewController = [UIViewController new];
        [modifiedVCs insertObject:viewController atIndex:_insertIndex];
    }
    [super setViewControllers:modifiedVCs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGFloat barWidth = CGRectGetWidth(self.tabBar.frame)/(self.viewControllers.count);
    CGFloat barHeight = CGRectGetHeight(self.tabBar.frame) + 20;

    _centerButton.frame = CGRectMake(barWidth*_insertIndex, CGRectGetHeight(self.tabBar.frame) - barHeight , barWidth, barHeight );
    [self.tabBar bringSubviewToFront:_centerButton];
    [_centerButton setImage:DZCachedImageByName(@"tab_upload_feed") forState:UIControlStateNormal];
    
}



@end
