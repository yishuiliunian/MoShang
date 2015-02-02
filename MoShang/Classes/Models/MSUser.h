//
//  MSUser.h
//  MoShang
//
//  Created by stonedong on 15/2/1.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MSUser : NSManagedObject

@property (nonatomic, retain) NSString * avarterURL;
@property (nonatomic, retain) NSString * nickName;
@property (nonatomic, retain) NSString * guid;

@end
