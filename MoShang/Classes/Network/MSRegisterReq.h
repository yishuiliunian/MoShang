//
//  MSRegisterReq.h
//  MoShang
//
//  Created by stonedong on 15/2/4.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSRequest.h"
@interface MSRegisterReq : MSRequest
@property (nonatomic, strong) NSString* accountName;
@property (nonatomic, strong) NSString* password;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* phoneNumber;
@end
