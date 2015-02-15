//
//  MSTipsPool.h
//  MoShang
//
//  Created by stonedong on 15/2/15.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define MSDefaultTipsPool [MSTipsPool  defaultPool]
@interface MSTipsPool : NSObject
+ (MSTipsPool*) defaultPool;
- (void) showError:(NSError*)error;
@end
