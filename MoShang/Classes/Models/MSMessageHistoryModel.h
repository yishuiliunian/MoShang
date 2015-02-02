//
//  MSMessageHistoryModel.h
//  MoShang
//
//  Created by stonedong on 15/2/1.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "MSUser.h"
@class MSUser;

@interface MSMessageHistoryModel : NSManagedObject

@property (nonatomic, retain) NSString * lastMessage;
@property (nonatomic, retain) NSDate * updateDate;
@property (nonatomic, retain) MSUser *toUser;
@property (nonatomic, retain) MSUser *fromeUser;

@end
