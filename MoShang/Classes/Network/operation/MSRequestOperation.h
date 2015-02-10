//
//  MSRequestOperation.h
//  MoShang
//
//  Created by stonedong on 15/2/7.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSRequest.h"
@interface MSRequestOperation : NSOperation
@property (nonatomic, assign) int queueID;
@property (nonatomic, strong) MSRequest* request;
- (instancetype) initWithRequest:(MSRequest*)request;
@end
