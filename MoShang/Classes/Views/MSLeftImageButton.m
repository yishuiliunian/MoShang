//
//  MSLeftImageButton.m
//  MoShang
//
//  Created by stonedong on 15/1/28.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSLeftImageButton.h"

@implementation MSLeftImageButton
- (void) layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame));
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame), 0, CGRectGetWidth(self.frame) - CGRectGetMaxY(self.imageView.frame), CGRectGetHeight(self.frame));
}
@end
