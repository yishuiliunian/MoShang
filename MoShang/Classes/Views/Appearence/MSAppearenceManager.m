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
