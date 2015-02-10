//
//  MSCommentFeedReq.h
//  MoShang
//
//  Created by stonedong on 15/2/10.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSVerifyAuthorRequest.h"

@interface MSCommentFeedReq : MSVerifyAuthorRequest
@property (nonatomic, strong) NSString* feedid;
@property (nonatomic, strong) NSString* talkid;
@end
