//
//  MSFeedDataController.m
//  MoShang
//
//  Created by stonedong on 15/3/6.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSFeedDataController.h"
#import "MSFeedsTableViewController.h"
@interface MSFeedDataController () 
{
    BOOL _isDataSyncing;
}
@end

@implementation MSFeedDataController


- (void) beginReloadData
{
    _isDataSyncing = YES;
    
    if ([self.delegate respondsToSelector:@selector(didBeginReloadData)]) {
        [self.delegate didBeginReloadData];
    }
}

- (void) finishReloadData:(BOOL)succeed error:(NSError*)error
{
    _isDataSyncing = NO;
    if (succeed) {
        if (self.delegate) {
            [self.delegate.tableView reloadData];
        }
    } else {
        
    }
    if (self.delegate) {
        [self.delegate didEndReloadData];
    }
}

- (void) request:(MSRequest *)request onError:(NSError *)error
{
    [self finishReloadData:NO error:error];
}

- (void) request:(MSRequest *)request onSucced:(id)object
{
    _feeds = [(NSArray*)object mutableCopy];
    [self finishReloadData:YES error:nil];
}

@end
