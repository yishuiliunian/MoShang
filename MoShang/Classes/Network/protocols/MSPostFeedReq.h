//
//  MSPostFeedReq.h
//  MoShang
//
//  Created by stonedong on 15/2/7.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSVerifyAuthorRequest.h"

@interface MSPostFeedReq : MSVerifyAuthorRequest
@property (nonatomic, strong) NSString* piclist;
@property (nonatomic, strong) NSString* backgroundColor;
@property (nonatomic, strong) NSString* position;
@property (nonatomic, strong) NSString* content;
@end
