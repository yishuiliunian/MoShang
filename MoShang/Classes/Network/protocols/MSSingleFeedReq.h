//
//  MSSingleFeedReq.h
//  MoShang
//
//  Created by stonedong on 15/2/7.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSRequest.h"
#import "MSVerifyAuthorRequest.h"

@interface MSSingleFeedReq : MSVerifyAuthorRequest
@property (nonatomic, strong) NSString* feedID;
@end
