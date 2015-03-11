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
#import "MSCommentsViewController.h"
@interface MSFeedDetailViewController ()
@property (nonatomic, strong) MSFeedDetailView* detailTopView;
@property (nonatomic, strong) MSCommentsViewController* commentsViewController;
@property (nonatomic, strong) UILabel* commentCountLabel;
@end
@implementation MSFeedDetailViewController
- (void) dz_addChildViewController:(UIViewController*)vc
{
    [vc willMoveToParentViewController:self];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    [vc didMoveToParentViewController:self];
}
- (void) viewDidLoad
{
    [super viewDidLoad];
    _detailTopView = [MSFeedDetailView new];
    [self.view addSubview:_detailTopView];
    
    _detailTopView.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = MSDefaultBackgroundColor();
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
    _detailTopView.contentLabel.text = @"xxxxxxxxjklklfasjdklfjaskldfjaksldfjkalsdfjlkasdfjlkasdjfklasdjflkasdjfklasdjflkasdjfklasjfklajsdxxxxx";
    _detailTopView.nickLabel.text = @"xxxxx";
    _detailTopView.layer.cornerRadius = 5;
    [_detailTopView setNeedsLayout];
    
    _commentsViewController = [MSCommentsViewController new];
    _commentsViewController.feedID = self.feed.recordid;
    
    [self dz_addChildViewController:_commentsViewController];
    
    _commentCountLabel = [UILabel new];
    [self.view addSubview:_commentCountLabel];
    
    
    [self loadFeed];
}

- (void) setFeed:(MSFeed *)feed
{
    if (_feed != feed) {
        _feed = feed;
        [self loadFeed];
    }
}

- (void) loadFeed
{
    _commentCountLabel.text = @"有14个人回应";
    _detailTopView.nickLabel.text = _feed.nick;
    _detailTopView.contentLabel.text = _feed.content;
    [_detailTopView.photosViewController setPhotos:MSPicturesListFromStr(_feed.piclist)];
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _detailTopView.frame = CGRectMake(10, 44, CGRectGetViewControllerWidth - 20, 300);
    CGRect rect = _detailTopView.frame;
    rect.size.height = _detailTopView.estamitHeight;
    _detailTopView.frame = rect;
    
    _commentCountLabel.frame = CGRectMake(10, CGRectGetMaxY(_detailTopView.frame), CGRectGetViewControllerHeight - 20, 30);
    
    _commentsViewController.view.frame = CGRectMake(0, CGRectGetMaxY(_commentCountLabel.frame), CGRectGetViewControllerWidth, CGRectGetViewControllerHeight - CGRectGetMaxY(_commentCountLabel.frame));
}
@end
