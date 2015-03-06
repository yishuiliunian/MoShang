//
//  MSFeedCell.h
//  MoShang
//
//  Created by stonedong on 15/1/27.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSFeedLayoutItem.h"

@class MSFeedCell;
@protocol MSFeedCellDelegate
- (void) feedCell:(MSFeedCell*)cell didTapLiaoLiaoBtn:(MSFeed*)feed;
@end
@interface MSFeedCell : UITableViewCell
@property (nonatomic, weak) NSObject<MSFeedCellDelegate>* delegate;
@property (nonatomic, strong) MSFeed* feed;

@end
