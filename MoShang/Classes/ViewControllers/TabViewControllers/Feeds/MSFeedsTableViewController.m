//
//  MSFeedsTableViewController.m
//  MoShang
//
//  Created by stonedong on 15/1/23.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSFeedsTableViewController.h"
#import "MSFeedCell.h"
#import "MSFeedLayoutItem.h"
#import "MSFeed.h"
#import "MSLayoutEngine.h"
#import <DZGeometryTools.h>
#import "MSGetFeedByPosReq.h"
#import "MSSyncCenter.h"
#import <RCIM.h>
#import <RCChatViewController.h>
#import <CBStoreHouseRefreshControl.h>
#import "MSFeedDetailViewController.h"
#import "MSUserInfoProvider.h"
@interface MSFeedsTableViewController () <MSRequestUIDelegate, MSFeedCellDelegate >
@property (nonatomic, assign) int lastRequestID;
@property (nonatomic, strong) CBStoreHouseRefreshControl* storeRefreshControl;
@end

@implementation MSFeedsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   

    self.tableView.backgroundColor = MSDefaultBackgroundColor();
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView reloadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.storeRefreshControl = [CBStoreHouseRefreshControl attachToScrollView:self.tableView target:self refreshAction:@selector(reloadData) plist:@"storehouse"];
    [self reloadData];
}

- (void) setFeedDataController:(MSFeedDataController *)feedDataController
{
    if (_feedDataController != feedDataController) {
        _feedDataController = feedDataController;
        _feedDataController.delegate = self;
        if (self.isViewLoaded) {
            [self reloadData];
        }
    }
}
- (void) reloadData
{
    if (!self.feedDataController.isDataSyncing) {
        [self.feedDataController beginReloadData];
    }
}

- (void) didBeginReloadData
{
    
}
- (void) didEndReloadData
{
    [self.storeRefreshControl finishingLoading];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.feedDataController.feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"feed-cell";
    MSFeedCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[MSFeedCell alloc]  initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.delegate = self;
    }
    MSFeed* feed = [self.feedDataController.feeds objectAtIndex:indexPath.row];
    cell.feed = feed;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MSFeed* feed = [self.feedDataController.feeds objectAtIndex:indexPath.row];
    return feed.layoutItem.layoutSize.height;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.alpha = 0.4;
    CGRect oldFrame = cell.frame;
    cell.frame = CGRectCenterSubSize(cell.frame, CGSizeMake(0, 70));
    [UIView animateWithDuration:0.4 animations:^{
        cell.alpha = 1;
        cell.frame = oldFrame;
    }];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MSFeed* feed = [self.feedDataController.feeds objectAtIndex:indexPath.row];
 
    MSFeedDetailViewController* detailVC = [MSFeedDetailViewController new];
    detailVC.feed = feed;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void) feedCell:(MSFeedCell *)cell didTapLiaoLiaoBtn:(MSFeed *)feed
{
    [[MSUserInfoProvider shareProvider] cacheUserID:feed.author nickName:feed.nick avatar:feed.head];
    RCChatViewController *chatViewController = [[RCIM sharedRCIM]createPrivateChat:feed.author title:feed.nick completion:^(){
        // 创建 ViewController 后，调用的 Block，可以用来实现自定义行为。
    }];
 
    chatViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatViewController animated:YES];
}



#pragma mark ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.storeRefreshControl scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.storeRefreshControl scrollViewDidEndDragging];
}
@end
