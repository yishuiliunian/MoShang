//
//  MSFeed.h
//  MoShang
//
//  Created by stonedong on 15/1/28.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSModel.h"
#import "MSFeedLayoutItem.h"
#import <DZProgramDefines.h>
@interface MSFeed : MSModel
@property (nonatomic, strong) MSFeedLayoutItem* layoutItem;
DEFINE_PROPERTY_STRONG_NSString(detailText);
DEFINE_PROPERTY_STRONG_NSString(nickName);
DEFINE_PROPERTY_STRONG_NSString(avaterURL);
DEFINE_PROPERTY_STRONG_NSString(backgroundURL);
@end
