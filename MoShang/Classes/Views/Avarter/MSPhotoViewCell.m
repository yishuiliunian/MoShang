//
//  MSPhotoViewCell.m
//  MoShang
//
//  Created by stonedong on 15/3/3.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSPhotoViewCell.h"
#import <DZImageCache.h>
#import <HNKCache.h>
#import <UIImageView+Haneke.h>
@interface MSPhotoViewCell ()
DEFINE_PROPERTY_STRONG_UIImageView(avarterTipsImageView);
@end
@implementation MSPhotoViewCell
- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return self;
    }
    
    INIT_SUBVIEW_UIImageView(self.contentView, _photoImageView);
    INIT_SUBVIEW_UIImageView(self.contentView, _avarterTipsImageView);
    _avarterTipsImageView.image = DZCachedImageByName(@"avatar_corner");
    self.contentView.clipsToBounds = YES;
    HNKCacheFormat* format = MSFormatPhotoLittle;
    _photoImageView.hnk_cacheFormat = format;
    return self;
}
- (void) setIsFirst:(BOOL)isFirst
{
    _isFirst = isFirst;
    [self setNeedsLayout];
}
- (void) layoutSubviews
{
    [super layoutSubviews];
    _photoImageView.frame = self.contentView.bounds;
    if (self.isFirst) {
        _avarterTipsImageView.frame = CGRectMake(0, 0, 30, 30);
 
    } else {
        _avarterTipsImageView.frame = CGRectZero;
    }
}
@end
