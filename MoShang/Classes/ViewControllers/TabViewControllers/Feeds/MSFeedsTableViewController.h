//
//  MSFeedsTableViewController.h
//  MoShang
//
//  Created by stonedong on 15/1/23.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSFeedDataController.h"
@interface MSFeedsTableViewController : UITableViewController
@property (nonatomic, strong) MSFeedDataController* feedDataController;

- (void) didBeginReloadData;
- (void) didEndReloadData;
@end
