//
//  MSGlobal.h
//  MoShang
//
//  Created by stonedong on 15/1/28.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+Read.h"
#import "NSError+MS.h"
#import "UIViewController+Custom.h"
#import "MSAlertPool.h"
#import "MSTipsPool.h"
#import <DZGeometryTools.h>
#import "MSLayoutEngine.h"
#import <Haneke.h>
#import <UIImageView+Haneke.h>
#import <DZImageCache.h>
#import "MSAppearenceManager.h"
#define NUM_TO_STRING(x) [@(x) stringValue]
FOUNDATION_EXTERN BOOL IS_MSColorString(NSString* str);

#define MSGenerateRandomUUID MSGenRandomUUID()
FOUNDATION_EXTERN NSString* MSGenRandomUUID();

FOUNDATION_EXTERN NSString* MSCurrentTimeStapmStr();

FOUNDATION_EXTERN NSArray* MSPicturesListFromStr(NSString* str);
@interface MSGlobal : NSObject

@end

//Images
#define MSHeadFemale     DZCachedImageByName(@"default_avater_lady.png")
#define MSHeadMale          DZCachedImageByName(@"default_avater_man.png")

