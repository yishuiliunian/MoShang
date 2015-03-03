//
//  MSChoceProviceViewController.m
//  MoShang
//
//  Created by stonedong on 15/2/13.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSChoceProviceViewController.h"
#import "MSChinaMap.h"
#import "MSLabelProviceCollectionViewController.h"
#import "UIButton+Custom.h"
#import "MSGuideContentViewController.h"
#import "MSSetUserInfoReq.h"
#import "MSAlertPool.h"
#import "MSTipsPool.h"
@interface MSChoceProviceViewController () <MSRequestUIDelegate>
{
    MSLabelProviceCollectionViewController* _provicesCollectionVC;
    
    UIButton* _sendInfosButton;
}
@property (nonatomic, strong, readonly) MSChinaMap* chinaMap;
@end

@implementation MSChoceProviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _chinaMap = [MSChinaMap new];
    [self.scrollView addSubview:_chinaMap];
    
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(75, 30);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _provicesCollectionVC = [[MSLabelProviceCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
    [_provicesCollectionVC willMoveToParentViewController:self];
    [self addChildViewController:_provicesCollectionVC];
    [self.scrollView addSubview:_provicesCollectionVC.view];
    [_provicesCollectionVC didMoveToParentViewController:self];
    
    _provicesCollectionVC.chinaMap = self.chinaMap;
    
    
    _sendInfosButton = [UIButton CommonBlueButtonForTitle:@"开始" target:self action:@selector(sendUserInfos)];
    [self.scrollView addSubview:_sendInfosButton];
    // Do any additional setup after loading the view.
}

- (void) nextSetp
{
    [self.guideContentViewController.guideContentDelegate guideContentViewController:self.guideContentViewController finished:YES];
}


- (void) sendUserInfos
{
    self.guideContentViewController.userInfo.style= @"";
    MSSetUserInfoReq* setUserInfoReq = [MSSetUserInfoReq new];
    setUserInfoReq.userInfo = self.guideContentViewController.userInfo;
    [MSDefaultSyncCenter performRequest:setUserInfoReq];
    setUserInfoReq.uidelegate = self;
    
    [MSDefaultAlertPool showLoadingWithMessage:@"正在提交您的信息...."];
}

- (void) request:(MSRequest *)request onError:(NSError *)error
{
    [MSDefaultAlertPool hideAllAlert];
    [MSDefaultTipsPool showError:error];
}

- (void) request:(MSRequest *)request onSucced:(id)object
{
    [MSDefaultAlertPool hideAllAlert];
    [self nextSetp];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) viewWillLayoutSubviews
{
    self.headTitleLabel.frame = CGRectMake(10, 10, CGRectGetViewControllerWidth, 100);
    _chinaMap.frame = CGRectMake(0, CGRectGetMaxY(self.headTitleLabel.frame), CGRectGetViewControllerWidth, 200);
    _provicesCollectionVC.view.frame = CGRectMake(10, CGRectGetMaxY(_chinaMap.frame), CGRectGetViewControllerWidth - 20, 90);
    _sendInfosButton.frame = CGRectMake(10, CGRectGetMaxY(_provicesCollectionVC.view.frame), CGRectGetViewControllerWidth - 20, 44);
}

@end
