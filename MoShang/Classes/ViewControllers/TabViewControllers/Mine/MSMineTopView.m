//
//  MSMineTopView.m
//  MoShang
//
//  Created by stonedong on 15/1/28.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSMineTopView.h"
#import <DZProgramDefines.h>
#import <LKBadgeView.h>
#import <DZImageCache.h>
#import <UIImageView+Haneke.h>
#import "MSLayoutEngine.h"
@interface MSMineTopView ()
DEFINE_PROPERTY_STRONG_UIImageView(avartIntroImageView);
DEFINE_PROPERTY_STRONG_UIImageView(imageView1);
DEFINE_PROPERTY_STRONG_UIImageView(imageView2);
DEFINE_PROPERTY_STRONG_UIImageView(imageView3);
DEFINE_PROPERTY_STRONG_UIImageView(imageView4);
DEFINE_PROPERTY_STRONG(LKBadgeView*, ageBadgeView);
@end
@implementation MSMineTopView
- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return self;
    }
    INIT_SELF_SUBVIEW_UIImageView(_imageView1);
    INIT_SELF_SUBVIEW_UIImageView(_imageView2);
    INIT_SELF_SUBVIEW_UIImageView(_imageView3);
    INIT_SELF_SUBVIEW_UIImageView(_imageView4);
    INIT_SELF_SUBVIEW_UIImageView(_avartIntroImageView);
    INIT_SELF_SUBVIEW(LKBadgeView, _ageBadgeView);
    _avartIntroImageView.image = DZCachedImageByName(@"avatar_corner");
    
    HNKCacheFormat* format =  MSFormatPhotoLittle;
    _imageView1.hnk_cacheFormat = _imageView2.hnk_cacheFormat = _imageView3.hnk_cacheFormat = _imageView4.hnk_cacheFormat = format;
#define SetImageMasktToBounds(x) _imageView##x.layer.masksToBounds = YES;
    SetImageMasktToBounds(1);
    SetImageMasktToBounds(2);
    SetImageMasktToBounds(3);
    SetImageMasktToBounds(4);
    return self;
}
- (void) setImageURLs:(NSArray *)imageURLs
{
    for (int i = 0 ; i < imageURLs.count; i++) {
        NSString* url = [imageURLs objectAtIndex:i];
        NSURL* imageURL =[NSURL URLWithString:url];
        switch (i) {
            case 0:
                [_imageView1 hnk_setImageFromURL:imageURL];
                break;
                
            case 1:
                [_imageView2 hnk_setImageFromURL:imageURL];
                break;
                
                case 2:
                [_imageView3 hnk_setImageFromURL:imageURL];
                
                break;
                case 3:
                [_imageView4 hnk_setImageFromURL:imageURL];
                break;
            default:
                break;
        }
    }
}
- (void) layoutSubviews
{
    CGFloat width  = (CGRectGetWidth(self.bounds) - 10) / 4;
    CGRect rect = {{2,2},{width, width}};
    _imageView1.frame = rect;
    _imageView2.frame = CGRectOffset(rect, width+2, 0);
    _imageView3.frame = CGRectOffset(_imageView2.frame, width+2, 0);
    _imageView4.frame = CGRectOffset(_imageView3.frame, width+2, 0);
    _avartIntroImageView.frame = CGRectMake(2, 2, 40, 40);
}
@end
