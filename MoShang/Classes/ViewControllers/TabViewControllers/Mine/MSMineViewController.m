//
//  MSMineViewController.m
//  MoShang
//
//  Created by stonedong on 15/1/23.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSMineViewController.h"
#import "MSMineTopView.h"
#import "MSAvarterCollectionViewController.h"
#import "MSMyCardViewController.h"
#import "MSFeedsTableViewController.h"
#import <DZGeometryTools.h>
#import "DZSwipeViewController.h"
#import <DZImageCache.h>
#import "MSUserInfoReq.h"
#import "MSAccountManager.h"
#import "MSUserFeedDataController.h"

@interface MSMineViewController () <MSRequestUIDelegate>
{
    MSAvarterCollectionViewController* _avarterVC;
    DZSwipeViewController* _swipeVC;
}
@end

@implementation MSMineViewController

- (void) ms_addChildViewController:(UIViewController*)vc
{
    [vc willMoveToParentViewController:self];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    [vc didMoveToParentViewController:self];
}
- (void) initUIControls
{
    _avarterVC = [[MSAvarterCollectionViewController alloc] initWithAvarters:@[@"http://img1.mydrivers.com/img/20141014/46769b2731584375a308d455000bce3b.jpg",
                                                                               @"http://img1.mydrivers.com/img/20141014/46769b2731584375a308d455000bce3b.jpg",
                                                                               @"http://img1.mydrivers.com/img/20141014/46769b2731584375a308d455000bce3b.jpg",
                                                                               @"http://img1.mydrivers.com/img/20141014/46769b2731584375a308d455000bce3b.jpg"]
                                                                    itemSize:CGSizeMake(100, 100)];
    
    [self ms_addChildViewController:_avarterVC];
}

- (void) initDetailViewControllers
{
    MSMyCardViewController* cardVC = [MSMyCardViewController new];
    cardVC.swipeTitle = @"资料";
    cardVC.swipeImage = DZCachedImageByName(@"mine_jilu.png");
    MSFeedsTableViewController* postVC = [MSFeedsTableViewController new];
    
    MSUserFeedDataController* userFeedControl = [MSUserFeedDataController new];
    userFeedControl.uid = @"0";
    postVC.feedDataController = userFeedControl;
    postVC.swipeTitle = @"记录";
    postVC.swipeImage = DZCachedImageByName(@"mine_infos.png");
    
    

    DZSwipeViewController* swipeVC = [[DZSwipeViewController alloc] initWithViewControllers:@[cardVC, postVC]];
    
    [self ms_addChildViewController:swipeVC];
    
    _swipeVC = swipeVC;
    
    
}

- (void) reloadMyUserInfos
{
    MSUserInfoReq* infoReq = [MSUserInfoReq new];
    infoReq.uid = [MSCurrentAccount accountID];
    infoReq.uidelegate = self;
    [MSDefaultSyncCenter performRequest:infoReq];
}

- (void) request:(MSRequest *)request onError:(NSError *)error
{
    
}

- (void) request:(MSRequest *)request onSucced:(id)object
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self initUIControls];
    [self initDetailViewControllers];
    
    [self  reloadMyUserInfos];
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _avarterVC.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 100);
    _swipeVC.view.frame = CGRectMake(0, CGRectGetMaxY(_avarterVC.view.frame), CGRectGetViewControllerWidth, CGRectGetViewControllerHeight - CGRectGetMaxY(_avarterVC.view.frame) - 44);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
