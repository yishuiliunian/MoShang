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
@interface MSFeedsTableViewController () <MSRequestUIDelegate>
@property (nonatomic, strong) NSMutableArray* feeds;
@property (nonatomic, assign) int lastRequestID;
@end

@implementation MSFeedsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _feeds = [NSMutableArray new];

    self.tableView.backgroundColor = MSDefaultBackgroundColor();
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView reloadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self reloadData];
}

- (void) reloadData
{
    MSGetFeedByPosReq* request = [MSGetFeedByPosReq new];
    request.uidelegate = self;
    [MSDefaultSyncCenter performRequest:request];
}
- (void) request:(MSRequest *)request onError:(NSError *)error
{
    
}

- (void) request:(MSRequest *)request onSucced:(id)object
{
    _feeds = object;
    [self.tableView reloadData];
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
    return _feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"feed-cell";
    MSFeedCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[MSFeedCell alloc]  initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    MSFeed* feed = [_feeds objectAtIndex:indexPath.row];
    cell.feed = feed;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MSFeed* feed = [_feeds objectAtIndex:indexPath.row];
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
@end
