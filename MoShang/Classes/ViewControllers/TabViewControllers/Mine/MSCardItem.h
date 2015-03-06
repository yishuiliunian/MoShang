//
//  MSCardItem.h
//  MoShang
//
//  Created by stonedong on 15/3/5.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCardContent.h"
@interface MSCardItem : NSObject
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) MSCardContent* content;
@property (nonatomic, assign) float cellHeight;
@end
