//
//  MSLayout.m
//  MoShang
//
//  Created by stonedong on 15/1/27.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSLayout.h"
@interface MSLayout ()
{

}
@property (nonatomic, weak) MSLayout* _superLayout;
@end
@implementation MSLayout
@synthesize _superLayout = __superLayout;
@synthesize subLayouts = _sublayouts;
- (instancetype) init {
    self = [super init];
    if (!self) {
        return self;
    }
    __subLayouts = [NSMutableArray new];
    return self;
}

- (MSLayout*) superLayout
{
    return __superLayout;
}

- (NSArray*) subLayouts
{
    return [__superLayout copy];
}

- (CGSize) size
{
    CGSize size = _size;
    size.width -= _edgeInsets.left;
    size.width += _edgeInsets.right;
    
    size.height -= _edgeInsets.top;
    size.height -= _edgeInsets.bottom;
    return size;
}

- (void) addSubLayout:(MSLayout *)layout
{
    layout._superLayout = self;
    if (![__subLayouts containsObject:layout]) {
        [__subLayouts addObject:layout];
        [self recalculateSize];
    }
}

- (void) removeLayout:(MSLayout*)layout
{
    [__subLayouts removeObject:layout];
    [self recalculateSize];
}
- (void) removeFromSuperLayout
{
    [__superLayout removeLayout:self];
    __superLayout = nil;
}

- (void) recalculateSize
{
    
}
@end
