//
//  MSTextLayoutItem.m
//  MoShang
//
//  Created by stonedong on 15/1/28.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSTextLayoutItem.h"

@implementation MSTextLayoutItem

- (instancetype) initWithFont:(UIFont*)font maxWidth:(CGFloat)maxWidth
{
    self = [super init];
    if (!self) {
        return self;
    }
    _font = font;
    _maxWidth = maxWidth;
    return self;
}
- (void) setText:(NSString *)text
{
    if (_text != text) {
        _text = text;
        if (!_text) {
            _layoutSize  = CGSizeZero;
        } else {
            _layoutSize = [text sizeWithFont:_font constrainedToSize:CGSizeMake(_maxWidth, 10000)];
        }
    }
}
@end
