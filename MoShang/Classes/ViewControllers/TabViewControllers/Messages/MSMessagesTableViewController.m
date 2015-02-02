//
//  MSMessagesTableViewController.m
//  MoShang
//
//  Created by stonedong on 15/1/23.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSMessagesTableViewController.h"
#import "MSMessageCell.h"
#import <CoreData+MagicalRecord.h>
@interface MSMessagesTableViewController ()
@property (nonatomic, strong) NSMutableArray* messageHistoryArray;
@end

@implementation MSMessagesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _messageHistoryArray = [[MSMessageHistoryModel MR_findAll] mutableCopy];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _messageHistoryArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"xxx";
    MSMessageCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[MSMessageCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    MSMessageHistoryModel* model = [_messageHistoryArray objectAtIndex:indexPath.row];
    cell.messageHistory = model;
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

@end
