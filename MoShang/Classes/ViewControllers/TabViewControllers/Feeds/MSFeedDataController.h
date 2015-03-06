//
//  MSFeedDataController.h
//  MoShang
//
//  Created by stonedong on 15/3/6.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSRequest.h"
#import <UIKit/UIKit.h>
@class MSFeedsTableViewController;
@interface MSFeedDataController : NSObject <MSRequestUIDelegate>
@property (nonatomic, weak) MSFeedsTableViewController* delegate;
@property (nonatomic, strong, readonly) NSArray* feeds;
@property (nonatomic, assign, readonly) BOOL isDataSyncing;

- (void) beginReloadData;
- (void) finishReloadData:(BOOL)succeed error:(NSError*)error;
@end
