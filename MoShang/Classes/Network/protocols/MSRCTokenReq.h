//
//  MSRCTokenReq.h
//  MoShang
//
//  Created by stonedong on 15/3/15.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSVerifyAuthorRequest.h"

@interface MSRCTokenReq : MSVerifyAuthorRequest
@property (nonatomic, strong) NSString* uid;
@property (nonatomic, assign) BOOL forced;
@end
