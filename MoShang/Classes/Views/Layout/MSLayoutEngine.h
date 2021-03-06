//
//  MSLayoutEngine.h
//  MoShang
//
//  Created by stonedong on 15/1/27.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSLayout.h"
#import "MSLineVerticalLayout.h"
#import "MSLineHorizontalLayout.h"
#import <HNKCache.h>
#define MSDefaultLayoutEngine [MSLayoutEngine defaultEngine]
#import "MSFeedLayoutItem.h"


FOUNDATION_EXTERN CGFloat MSScrrenWidth();
FOUNDATION_EXTERN CGFloat MSFeedCellWidth();
FOUNDATION_EXTERN CGFloat MSFeedCellMaxHeight();
FOUNDATION_EXTERN UIEdgeInsets MSFeedCellEdgeInsets();
FOUNDATION_EXTERN UIFont* MSDefaultDetailFont();
FOUNDATION_EXTERN UIColor* MSDefaultBackgroundColor();


CG_EXTERN CGFloat const MSDefaultCellSpace;
CG_EXTERN CGFloat const MSDefaultCellHeightSpace;
FOUNDATION_EXTERN HNKCacheFormat* HNKCreateCacheFormatWithSize(CGSize size, NSString* key);

#define MSFormatHeadLittle HNKCreateCacheFormatWithSize(CGSizeMake(100, 100), @"HeadCell_Little")
#define MSFormatFeedBackground HNKCreateCacheFormatWithSize(CGSizeMake(MSFeedCellWidth(), MSFeedCellMaxHeight()), @"backgourd_feed")
#define MSFormatPhotoLittle  HNKCreateCacheFormatWithSize(CGSizeMake(100, 100), @"HeadCell_Little")

@interface MSLayoutEngine : NSObject
+ (MSLayoutEngine*) defaultEngine;
@end
