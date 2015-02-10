//
//  MSLoginReq.h
//  MoShang
//
//  Created by stonedong on 15/2/7.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSRequest.h"

@interface MSLoginReq : MSRequest
@property (nonatomic, strong, readonly) NSString* token;
@property (nonatomic, strong) NSString* accountID;
@property (nonatomic, strong) NSString* password;
@end
