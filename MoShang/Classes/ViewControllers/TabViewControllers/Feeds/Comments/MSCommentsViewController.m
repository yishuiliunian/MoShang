//
//  MSCommentsViewController.m
//  MoShang
//
//  Created by stonedong on 15/3/6.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSCommentsViewController.h"
#import "MSGetSingleFeedTalksReq.h"
#import "MSCommentCell.h"
#import "MSGlobal.h"
@interface MSCommentsViewController () <MSRequestUIDelegate>
{
    NSArray* _comments;
}
@end
@implementation MSCommentsViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = MSDefaultBackgroundColor();
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self reloadData];
}

- (void) reloadData
{
    MSGetSingleFeedTalksReq* req = [MSGetSingleFeedTalksReq new];
    req.feedID = self.feedID;
    req.uidelegate = self;
    [MSDefaultSyncCenter performRequest:req];
    
}

- (void) request:(MSRequest *)request onError:(NSError *)error
{
    [self testReload];
}

- (void) request:(MSRequest *)request onSucced:(id)object
{
    [self testReload];
}

- (void) testReload
{
    NSMutableArray* array = [NSMutableArray new];
    for (int i = 0; i < 10; i++) {
        MSComment* c = [MSComment new];
        [array addObject:c];
    }
    
    _comments = array;
    [self.tableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"feed-cell";
    MSCommentCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[MSCommentCell alloc]  initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    MSComment* commnent = [_comments objectAtIndex:indexPath.row];
    cell.comment = commnent;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
