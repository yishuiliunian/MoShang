//
//  MSRCUserInfo.h
//  MoShang
//
//  Created by stonedong on 15/3/15.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "RLMObject.h"
#import "MSGlobal.h"

@interface MSRCUserInfo : RLMObject
@property (nonatomic, strong) NSString* userId;
@property (nonatomic, strong) NSString* nickName;
@property (nonatomic, strong) NSString* avatarURL;
- (BOOL) checkValid;
@end

RLM_ARRAY_TYPE(MSRCUserInfo);