//
//  DZTabView.m
//  Pods
//
//  Created by stonedong on 15/3/5.
//
//

#import "DZTabView.h"
#import "DZTabViewItem.h"
#import "DZTabViewItem_Private.h"
@interface DZTabView ()
{
    NSArray* _items;
    UIView* _selectedView;
    
    NSInteger _lastSelectedIndex;
    
    CGFloat _selectedItemOffSet;
}
@end
@implementation DZTabView
@synthesize delegate;
@synthesize lastSelectedIndex = _lastSelectedIndex;
- (instancetype) initWithItems:(NSArray *)items
{
    self = [super init];
    if (!self) {
        return self;
    }
    
    NSAssert(items.count != 0, @"no any tabitem, please add one");
    
    [self setItems:items];
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return self;
    }
    _selectedView = [UIView new];
    [self addSubview:_selectedView];
    
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRegc:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
    
    _selectedItemOffSet = 0.0f;
    
    _selectedView = [UIView new];
    _selectedView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_selectedView];
    return self;
}

- (void) handleTapGestureRegc:(UITapGestureRecognizer*)tapRcg
{
    if (tapRcg.state == UIGestureRecognizerStateRecognized) {
        CGPoint point = [tapRcg locationInView:self];
        
        int selectedIndex = NSNotFound;
        for (int i = 0 ; i<_items.count; i++) {
            DZTabViewItem* item = _items[i];
            if (CGRectContainsPoint(item.frame, point)) {
                selectedIndex = i;
                break;
            }
        }
        if (selectedIndex != NSNotFound) {
            if ([self.delegate respondsToSelector:@selector(dz_tabView:didSelectedAtIndex:)]) {
                [self.delegate dz_tabView:self didSelectedAtIndex:selectedIndex];
            }
        }
        [self setLastSelectedIndex:selectedIndex animate:YES];
    }
}
- (void) setSelectedIndex:(NSInteger)index
{
    [self setLastSelectedIndex:index animate:NO];
}
- (void) setLastSelectedIndex:(NSInteger)index animate:(BOOL)animate
{
    if (index < 0 || index >= _items.count) {
        return;
    }
    if (_lastSelectedIndex == index) {
        return;
    }
    
    DZTabViewItem* item = _items[index];
    item.selected = YES;
    
    DZTabViewItem* lastItem = _items[_lastSelectedIndex];
    lastItem.selected = NO;
    _lastSelectedIndex = index;
    if (animate) {
        [UIView animateWithDuration:0.25 animations:^{
            _selectedView.frame = item.frame;
        } completion:^(BOOL finished) {
        }];
    }
    else {
        _lastSelectedIndex = index;
    }
}
- (void) setItems:(NSArray*)items
{
    for (DZTabViewItem* item in _items) {
        [item removeFromSuperview];
    }
    
    _items = items;
    
    for (DZTabViewItem* item in _items) {
        [self addSubview:item];
    }
    
    [self setNeedsLayout];
}
- (void) layoutSubviews
{
    [super layoutSubviews];
    NSUInteger count = _items.count;
    CGFloat itemSpace = CGRectGetWidth(self.bounds) / count;
    
    CGFloat startX = 0;
    for (DZTabViewItem* item in _items) {
        item.frame = CGRectMake(startX, 0, itemSpace, CGRectGetHeight(self.bounds));
        startX = CGRectGetMaxX(item.frame);
        
    }
    if (_lastSelectedIndex != NSNotFound) {
        DZTabViewItem* selectedItem = _items[_lastSelectedIndex];
        _selectedView.frame = CGRectMake(CGRectGetMinX(selectedItem.frame) -  _selectedItemOffSet * CGRectGetWidth(selectedItem.frame), 0, CGRectGetWidth(selectedItem.frame), CGRectGetHeight(self.frame));
    }

}



- (void) setSelectedViewOffSetRatio:(CGFloat)ratio
{
    _selectedItemOffSet = ratio;
    [self setNeedsLayout];
}
@end
