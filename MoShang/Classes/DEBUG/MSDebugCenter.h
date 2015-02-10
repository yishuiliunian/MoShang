//
//  MSDebugCenter.h
//  MoShang
//
//  Created by stonedong on 15/2/7.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MSDebugCenter : NSObject
+ (MSDebugCenter*) shareCenter;
- (void) globalTest;
@end
