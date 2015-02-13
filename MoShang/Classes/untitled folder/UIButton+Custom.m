//
//  UIButton+Custom.m
//  MoShang
//
//  Created by stonedong on 15/2/13.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "UIButton+Custom.h"
#import <DZImageCache.h>
@implementation UIButton (Custom)
+ (UIButton*)commonBigButtonForTitle:(NSString*)title target:(id)target action:(SEL)action bgImageNormal:(NSString*)bgImageNormal bgImageHighlighted:(NSString*)bgImageHighlighted
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage*(^ResizeImage)(UIImage*image) = ^(UIImage* bgImage) {
        UIImage* a = [bgImage stretchableImageWithLeftCapWidth:bgImage.size.width / 2 topCapHeight:bgImage.size.height / 2];
        return a;
    };
    [button setBackgroundImage:ResizeImage(DZCachedImageByName(bgImageNormal)) forState:UIControlStateNormal];
    [button setBackgroundImage:ResizeImage(DZCachedImageByName(bgImageHighlighted)) forState:UIControlStateNormal];
    [button setBackgroundImage:ResizeImage(DZCachedImageByName(@"common_big_button_disabled.png")) forState:UIControlStateDisabled];
    [button setTitle:title forState:UIControlStateNormal];
    if(action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}

+ (UIButton*) CommonBlueButtonForTitle:(NSString*)title target:(id)target action:(SEL)action
{
    return [UIButton commonBigButtonForTitle:title target:target action:action bgImageNormal:@"common_big_button_focus_nor.png" bgImageHighlighted:@"common_big_button_focus_pressed.png"];
}
@end
