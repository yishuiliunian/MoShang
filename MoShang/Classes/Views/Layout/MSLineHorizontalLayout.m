//
//  MSLineHorizontalLayout.m
//  MoShang
//
//  Created by stonedong on 15/1/27.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSLineHorizontalLayout.h"

@implementation MSLineHorizontalLayout
- (void) recalculateSize
{
    CGSize size;
    for (MSLayout* layout in __subLayouts) {
        size.width += layout.size.width;
    }
    size.height = _size.height;
    size.height += self.subLayoutSpace * (__subLayouts.count -1);
    _size = size;
}
@end
