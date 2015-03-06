//
//  MSPosFeedDataController.m
//  MoShang
//
//  Created by stonedong on 15/3/6.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSPosFeedDataController.h"
#import "MSGetFeedByPosReq.h"
@implementation MSPosFeedDataController
- (void) beginReloadData
{
    MSGetFeedByPosReq* request = [MSGetFeedByPosReq new];
    request.uidelegate = self;
    [MSDefaultSyncCenter performRequest:request];
    [super beginReloadData];
}
@end
