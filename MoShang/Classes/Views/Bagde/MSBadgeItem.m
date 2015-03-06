//
//  MSBadgeItem.m
//  MoShang
//
//  Created by stonedong on 15/3/6.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSBadgeItem.h"
#import <UIKit/UIKit.h>
@implementation MSBadgeItem
- (instancetype) initWithText:(NSString *)text
{
    self = [super init];
    if (!self) {
        return self;
    }
    _text = text;
    return self;
}
- (double) badgeWidth
{
    return [self.text sizeWithFont:self.font].width + 12;
}
@end
