//
//  MSProviceView.m
//  MoShang
//
//  Created by stonedong on 15/2/10.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSProviceView.h"
#import <DZImageCache.h>
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
@implementation MSProviceView
- (void) setProvince:(MSProvice *)province
{
    if (_province != province) {
        _province = province;
        self.image = province.image;
        _province.view = self;
    }
}
@end
