//
//  MSUserFeedDataController.m
//  MoShang
//
//  Created by stonedong on 15/3/6.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSUserFeedDataController.h"
#import "MSGetFeedByUidReq.h"
@implementation MSUserFeedDataController
- (void) beginReloadData
{
    MSGetFeedByUidReq* uidReq = [MSGetFeedByUidReq new];
    uidReq.uid = self.uid;
    uidReq.uidelegate = self;
    [MSDefaultSyncCenter performRequest:uidReq];
    [super beginReloadData];
}
@end
