//
//  MSFeedDetailViewController.m
//  MoShang
//
//  Created by stonedong on 15/3/6.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSFeedDetailViewController.h"
#import "MSFeedDetailView.h"
#import "MSGlobal.h"
@interface MSFeedDetailViewController ()
@property (nonatomic, strong) MSFeedDetailView* detailTopView;
@end
@implementation MSFeedDetailViewController
- (void) viewDidLoad
{
    [super viewDidLoad];
    _detailTopView = [MSFeedDetailView new];
    [self.view addSubview:_detailTopView];
    
    _detailTopView.badgeContentView.items = @[MSBadgeItemWithText(@"xxxx"),
                                              MSBadgeItemWithText(@"^x"),
                                              MSBadgeItemWithText(@"xxx"),
                                              MSBadgeItemWithText(@"游戏"),
                                              MSBadgeItemWithText(@"xxx"),
                                              MSBadgeItemWithText(@"xxx"),
                                              MSBadgeItemWithText(@"xxx"),
                                              MSBadgeItemWithText(@"xxx"),
                                              MSBadgeItemWithText(@"xxx"),
                                              MSBadgeItemWithText(@"xxx"),
                                              MSBadgeItemWithText(@"xxx"),
                                              MSBadgeItemWithText(@"xxx"),
                                              MSBadgeItemWithText(@"xxx"),
                                              MSBadgeItemWithText(@"xxx"),
                                              MSBadgeItemWithText(@"xxx"),
                                              MSBadgeItemWithText(@"xxx"),
                                              MSBadgeItemWithText(@"xxx")];
    
}
- (void) setFeed:(MSFeed *)feed
{
    if (_feed != feed) {
        _feed = feed;
    }
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _detailTopView.frame = CGRectMake(0, 120, CGRectGetViewControllerWidth, 200);
}
@end
