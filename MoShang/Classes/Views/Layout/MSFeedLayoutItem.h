//
//  MSFeedLayoutItem.h
//  MoShang
//
//  Created by stonedong on 15/1/28.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSLayoutItem.h"
#import "MSTextLayoutItem.h"
extern  CGFloat const MSFeedHeadImageSizeWidth;
extern CGFloat const MSFeedMaxHeight;
@class MSFeed;
@interface MSFeedLayoutItem : MSLayoutItem
@property (nonatomic, strong) MSTextLayoutItem* detailTextLayout;
@property (nonatomic, strong) MSLayoutItem* topLayoutItem;
@property (nonatomic, strong) MSLayoutItem* bottomLayoutItem;
@property (nonatomic, strong) MSLayoutItem* backgroundLayoutItem;
@property (nonatomic, assign) CGFloat contentWidth;
@property (nonatomic, assign) CGFloat maxWidth;
- (void) decodeLayoutWithFeed:(MSFeed*)feed;
- (instancetype) initWithMaxWidth:(CGFloat)maxWidth edgeInsets:(UIEdgeInsets)edge;
@end
