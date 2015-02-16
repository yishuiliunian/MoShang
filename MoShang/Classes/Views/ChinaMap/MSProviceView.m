//
//  MSProviceView.m
//  MoShang
//
//  Created by stonedong on 15/2/10.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSProviceView.h"
#import <DZImageCache.h>
#import <DZGeometryTools.h>
#import <DZProgramDefines.h>
@implementation MSProvice
- (instancetype) initWithProviceImage:(NSString *)name highlightImage:(NSString *)hiname scaleRect:(CGRect)scaleRect
{
    self = [super init];
    if (!self) {
        return self;
    }
    _name = name;
    _image = DZCachedImageByName(_name);
    CGSize originSize = CGSizeMake(640, 505);
    CGSize size =_image.size;
    scaleRect.size = CGSizeMake(size.width/originSize.width, size.height/originSize.height);
    scaleRect.origin = CGPointMake(scaleRect.origin.x/originSize.width, scaleRect.origin.y/originSize.height);
    _hightlightImage = DZCachedImageByName(hiname);
    _scaleRect = scaleRect;
    return self;
}
@end

@interface MSProviceView ()
{
    UIImageView* _selectedImageView;
}
@end

@implementation MSProviceView
- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return self;
    }
    INIT_SELF_SUBVIEW_UIImageView(_selectedImageView);
    _selectedImageView.image = DZCachedImageByName(@"flower.png");
    [self setSelected:NO];
    return self;
}
- (void) setProvince:(MSProvice *)province
{
    if (_province != province) {
        _province = province;
        self.image = province.image;
        _province.view = self;
    }
}

- (void) setSelected:(BOOL)selected
{
    _selected = selected;
    if (_selected) {
        _selectedImageView.hidden = NO;
    } else {
        _selectedImageView.hidden = YES;
    }
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self.superview addSubview:_selectedImageView];
    CGRect rect;
    CGSize size = CGSizeMake(30, 30);
    CGPoint center = CGRectGetCenter(self.frame);
    rect.origin = CGPointSubtraction(center, CGPointMake(size.width/2, size.height/2));
    rect.size = size;
    _selectedImageView.frame = rect;
}
@end
