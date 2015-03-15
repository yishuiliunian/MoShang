//
//  MSBadgeContentView.h
//  MoShang
//
//  Created by stonedong on 15/3/6.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSBadgeItem.h"
@interface MSBadgeContentView : UIView
@property (nonatomic, strong) NSArray* items;
@property (nonatomic, assign) BOOL multiLines;
@property (nonatomic, strong) UIFont* font;
- (instancetype) initWithItems:(NSArray*)items;
@end
