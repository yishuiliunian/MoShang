//
//  MSSetUserInfoReq.h
//  MoShang
//
//  Created by stonedong on 15/2/10.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSVerifyAuthorRequest.h"
#import "MSUserInfo.h"
@interface MSSetUserInfoReq : MSVerifyAuthorRequest
@property (nonatomic, strong) MSUserInfo* userInfo;
@end
