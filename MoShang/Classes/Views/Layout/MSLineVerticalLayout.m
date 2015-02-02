//
//  MSLineVerticalLayout.m
//  MoShang
//
//  Created by stonedong on 15/1/27.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSLineVerticalLayout.h"

@implementation MSLineVerticalLayout
- (void) recalculateSize
{
    CGSize size ;
    for (MSLayout* layout in __subLayouts) {
        size.height += layout.size.height;
    }
    size.width = _size.width;
    size.width += (__subLayouts.count - 1) *self.subLayoutSpace;
    _size = size;
}

- (void) layout
{
    CGFloat height = _size.height - self.edgeInsets.top + self.edgeInsets.bottom;
    CGFloat startx = self.edgeInsets.left;
    
    for (MSLayout* layout in __subLayouts) {
        CGSize size = layout.size;
        layout.layoutView.frame = CGRectMake(startx, self.edgeInsets.top, size.width, height);
    }
}
@end
