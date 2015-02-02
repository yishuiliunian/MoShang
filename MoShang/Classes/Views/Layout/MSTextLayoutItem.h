//
//  MSTextLayoutItem.h
//  MoShang
//
//  Created by stonedong on 15/1/28.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSLayoutItem.h"

@interface MSTextLayoutItem : MSLayoutItem
@property (nonatomic, assign) CGFloat maxWidth;
@property (nonatomic, strong) UIFont* font;
@property (nonatomic, copy) NSString* text;

- (instancetype) initWithFont:(UIFont*)font maxWidth:(CGFloat)maxWidth;
@end
