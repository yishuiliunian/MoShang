//
//  MSGetFeedByUidReq.h
//  MoShang
//
//  Created by stonedong on 15/2/10.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSVerifyAuthorRequest.h"

@interface MSGetFeedByUidReq : MSVerifyAuthorRequest
@property (nonatomic, strong) NSString* uid;
@property (nonatomic, assign) NSTimeInterval createDate;
@property (nonatomic, assign) int d;
@end
