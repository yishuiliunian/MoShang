//
//  MSSetLikeReq.h
//  MoShang
//
//  Created by stonedong on 15/2/10.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSVerifyAuthorRequest.h"

@interface MSSetLikeReq : MSVerifyAuthorRequest
@property (nonatomic, strong) NSString* feedid;
@property (nonatomic, assign) BOOL bLike;
@end
