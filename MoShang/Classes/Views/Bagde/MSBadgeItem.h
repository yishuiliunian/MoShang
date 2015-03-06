//
//  MSBadgeItem.h
//  MoShang
//
//  Created by stonedong on 15/3/6.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define MSBadgeItemWithText(t) [[MSBadgeItem alloc]initWithText:t]
@interface MSBadgeItem : NSObject
@property (nonatomic, strong) NSString* text;
@property (nonatomic, strong) UIFont* font;
@property (nonatomic, assign, readonly) double badgeWidth;
- (instancetype) initWithText:(NSString*)text;
@end
