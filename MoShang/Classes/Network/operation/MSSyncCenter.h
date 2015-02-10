//
//  MSSyncCenter.h
//  MoShang
//
//  Created by stonedong on 15/2/7.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#define MSDefaultSyncCenter [MSSyncCenter defaultCenter]
@class MSRequest;
@interface MSSyncCenter : NSObject
+ (MSSyncCenter*) defaultCenter;
- (int) performRequest:(MSRequest*)request;
@end
