//
//  MSChinaMap.m
//  MoShang
//
//  Created by stonedong on 15/2/10.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSChinaMap.h"
#import "MSProviceView.h"
@interface MSProvice : NSObject
@property (nonatomic, strong) NSString* pictureName;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, assign) float mapScale;
@end
@implementation MSProvice


@end
@interface MSChinaMap ()
{
    NSMutableArray* _proviceViews;
}
@end
@implementation MSChinaMap

@end
