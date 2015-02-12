//
//  MSChinaMap.m
//  MoShang
//
//  Created by stonedong on 15/2/10.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSChinaMap.h"
#import "MSProviceView.h"
#import <DZImageCache.h>



@interface MSChinaMap ()
{
    NSArray* _provices;
}
@end
@implementation MSChinaMap

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return self;
    }
  
#define Province(name, hightName , x ,y , w ,h) [[MSProvice alloc] initWithProviceImage:name highlightImage:hightName scaleRect:CGRectMake(x, y, w, h)]
    
    _provices = @[Province(@"安徽.png", @"", 423, 288, 0.5, 0.5),
                  Province(@"北京.png", @"", 430, 209, 0.5, 0.5),
                  Province(@"重庆.png", @"", 328, 318, 0.5, 0.5),
                 Province(@"福建.png", @"", 435, 365, 0.5, 0.5),
                  Province(@"甘肃.png", @"", 200, 183, 0.5, 0.5),
                  Province(@"广东.png", @"", 367, 390, 0.5, 0.5),
                  Province(@"广西.png", @"", 320, 381, 0.5, 0.5),
                  Province(@"贵州.png", @"", 312, 354, 0.5, 0.5),
                  Province(@"海南.png", @"", 363, 449, 0.5, 0.5),
                  Province(@"河北.png", @"", 408, 182, 0.5, 0.5),
                  Province(@"河南.png", @"", 379, 266, 0.5, 0.5),
                  Province(@"黑龙江.png", @"", 487, 27, 0.5, 0.5),
                  Province(@"湖北.png", @"", 358, 303, 0.5, 0.5),
                  Province(@"湖南.png", @"", 358, 338, 0.5, 0.5),
                  Province(@"吉林.png", @"", 489, 136, 0.5, 0.5),
                  Province(@"江苏.png", @"", 437, 284, 0.5, 0.5),
                  Province(@"江西.png", @"", 410, 340, 0.5, 0.5),
                  Province(@"辽宁.png", @"", 462, 174, 0.5, 0.5),
                  Province(@"内蒙古.png", @"", 251, 28, 0.5, 0.5),
                  Province(@"宁夏.png", @"", 317, 277, 0.5, 0.5),
                  Province(@"青海.png", @"", 172, 231, 0.5, 0.5),
                  Province(@"山东.png", @"", 416, 242, 0.5, 0.5),
                  Province(@"山西.png", @"", 379, 251, 0.5, 0.5),
                  Province(@"陕西.png", @"", 335, 288, 0.5, 0.5),
                  Province(@"上海.png", @"", 484, 321, 0.5, 0.5),
                  Province(@"四川.png", @"", 250, 294, 0.5, 0.5),
                  Province(@"台湾.png", @"", 474, 395, 0.5, 0.5),
                  Province(@"天津.png", @"", 442, 217, 0.5, 0.5),
                  Province(@"西藏.png", @"", 65, 264, 0.5, 0.5),
                  Province(@"新疆省.png", @"", 14, 92, 0.5, 0.5),
                  Province(@"云南.png", @"", 258, 320, 0.5, 0.5),
                  Province(@"浙江.png", @"", 343, 360, 0.5, 0.5)
                  ];
    
    for (MSProvice* provice in _provices) {
        MSProviceView* view = [[MSProviceView alloc] init];
        [self addSubview:view];
        view.province = provice;
        provice.view = view;
    }
    return self;
}

- (void) layoutSubviews
{
    for (MSProvice* provice in _provices) {
        MSProviceView* view = provice.view;
        CGPoint origin = CGPointMake(provice.scaleRect.origin.x*CGRectGetWidth(self.frame), provice.scaleRect.origin.y*CGRectGetHeight(self.frame));
        CGSize size = CGSizeMake(provice.scaleRect.size.width*CGRectGetWidth(self.frame), provice.scaleRect.size.height* CGRectGetHeight(self.frame));
        CGRect rect;
        rect.origin = origin;
        rect.size = size;
        view.frame = rect;
    }
}
@end
