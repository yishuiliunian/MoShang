//
//  MSAppearenceManager.h
//  MoShang
//
//  Created by stonedong on 15/3/4.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MSAppearenceManager : NSObject
+ (MSAppearenceManager*) shareManager;
- (void) loadGlobalAppearence;
@end



FOUNDATION_EXTERN void MS_Decorate_Label_NickName(UILabel* label);
FOUNDATION_EXTERN void MS_Decorate_ImageView_Head(UIImageView* imageView);