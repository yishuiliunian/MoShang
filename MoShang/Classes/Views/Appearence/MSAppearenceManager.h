//
//  MSAppearenceManager.h
//  MoShang
//
//  Created by stonedong on 15/3/4.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSAppearenceManager : NSObject
+ (MSAppearenceManager*) shareManager;
- (void) loadGlobalAppearence;
@end
