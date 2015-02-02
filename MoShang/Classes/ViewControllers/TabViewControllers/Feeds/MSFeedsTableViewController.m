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
@interface MSFeedsTableViewController ()
@property (nonatomic, strong) NSMutableArray* feeds;
@end

@implementation MSFeedsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _feeds = [NSMutableArray new];
    for (int i = 0; i < 220; i++) {
        MSFeed* feed = [MSFeed new];
        if (i % 2 == 0) {
            feed.detailText = @"今天在酒吧遇见了一个人，很好很感动";
        } else {
            feed.detailText = @"a:";
        }
        feed.layoutItem = [[MSFeedLayoutItem alloc] init];
        [feed.layoutItem decodeLayoutWithFeed:feed];
        feed.avaterURL = @"http://www.baidu.com/img/bdlogo.png";
        feed.nickName = @"这是一个很好的例子";
        feed.backgroundURL = @"http://f.hiphotos.baidu.com/image/pic/item/0df431adcbef7609b639d99e2cdda3cc7cd99e85.jpg";
        [_feeds addObject:feed];
    }
    
    self.tableView.backgroundColor = MSDefaultBackgroundColor();
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView reloadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
