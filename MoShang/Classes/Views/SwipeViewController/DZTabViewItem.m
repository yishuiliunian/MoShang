//
//  DZTabViewItem.m
//  Pods
//
//  Created by stonedong on 15/3/5.
//
//

#import "DZTabViewItem.h"
#import "DZTabViewItem_Private.h"

@interface DZTabViewItemContentView : UIView
@property (nonatomic, strong, readonly) UILabel* textLabel;
@property (nonatomic, strong, readonly) UIImageView* imageView;
@property (nonatomic, assign)BOOL selected;
@end


@implementation DZTabViewItemContentView

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return self;
    }
    _textLabel = [UILabel new];
    [self addSubview:_textLabel];
    
    _imageView = [UIImageView new];
    [self addSubview:_imageView];
    
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat center = CGRectGetWidth(self.frame)/2;
    CGFloat imageWidth = 15;
    _imageView.frame = CGRectMake(center - imageWidth -5, (CGRectGetHeight(self.bounds) - imageWidth )/2, imageWidth, imageWidth);
    _textLabel.frame = CGRectMake(center, 0, center, CGRectGetHeight(self.bounds));
}

- (void) setSelected:(BOOL)selected
{
    _selected = selected;
    if (_selected) {
        _textLabel.textColor = [UIColor blackColor];
    } else {
        _textLabel.textColor = [UIColor blueColor];
    }
}

@end
@implementation DZTabViewItem
@synthesize selected = _selected;

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return self;
    }
    
    _contentView = [DZTabViewItemContentView new];
    [self addSubview:_contentView];

    return self;
}
- (UILabel*) textLabel
{
    if ([_contentView isKindOfClass:[DZTabViewItemContentView class]]) {
        return [(DZTabViewItemContentView*)_contentView textLabel];
    }
    return nil;
}

- (UIImageView*) imageView
{
    if ([_contentView isKindOfClass:[DZTabViewItemContentView class]]) {
        return [(DZTabViewItemContentView*)_contentView imageView];
    }
    return nil;
}
- (BOOL) isSelected
{
    return _selected;
}

- (void) setSelected:(BOOL)selected
{
    _selected = selected;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    _contentView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 5);
}
@end
