//
//  MSAppearenceManager.m
//  MoShang
//
//  Created by stonedong on 15/3/4.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSAppearenceManager.h"
#import <DZSingletonFactory.h>
#import <UIKit/UIKit.h>
#import <HexColor.h>
#import <UIImageView+Haneke.h>
#import "MSGlobal.h"
@implementation MSAppearenceManager
+ (MSAppearenceManager*) shareManager {
    return DZSingleForClass([MSAppearenceManager class]);
}

- (void) loadGlobalAppearence
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexString:@"#499df2"]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}
@end



void MS_Decorate_Label_NickName(UILabel* label) {
    label.textAlignment = UITextLayoutDirectionLeft;
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textColor = [UIColor blackColor];
}

void MS_Decorate_ImageView_Head(UIImageView* imageView) {
    imageView.hnk_cacheFormat = MSFormatHeadLittle;
    imageView.layer.masksToBounds = YES;
}

