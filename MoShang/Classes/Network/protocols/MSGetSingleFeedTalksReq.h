//
//  MSGetSingleFeedTalksReq.h
//  MoShang
//
//  Created by stonedong on 15/3/6.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSVerifyAuthorRequest.h"

@interface MSGetSingleFeedTalksReq : MSVerifyAuthorRequest
@property (nonatomic, strong) NSString* feedID;
@end