//
//  MSChinaMapController.m
//  MoShang
//
//  Created by stonedong on 15/2/11.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSChinaMapController.h"
#import "MSChinaMap.h"
#import <DZGeometryTools.h>
@implementation MSChinaMapController

- (void) loadView
{
    self.view = [[MSChinaMap alloc] initWithFrame:CGRectLoadViewFrame];
}
@end
