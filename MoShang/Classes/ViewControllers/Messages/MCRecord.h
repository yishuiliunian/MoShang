//
//  MCRecord.h
//  MoShang
//
//  Created by stonedong on 15/2/2.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCRecord : NSObject
@property (nonatomic, strong) NSString* fromUser;
@property (nonatomic, strong) NSString* toUser;
@property (nonatomic, strong) NSDate* updateDate;
@property (nonatomic, assign) int seq;
@end
