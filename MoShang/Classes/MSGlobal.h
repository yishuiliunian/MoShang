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
#import <Realm.h>
#import "MSAccountManager.h"
#import "MSGlobalStrings.h"
#define NUM_TO_STRING(x) [@(x) stringValue]
FOUNDATION_EXTERN BOOL IS_MSColorString(NSString* str);

#define MSGenerateRandomUUID MSGenRandomUUID()
FOUNDATION_EXTERN NSString* MSGenRandomUUID();

FOUNDATION_EXTERN NSString* MSCurrentTimeStapmStr();

FOUNDATION_EXTERN NSArray* MSPicturesListFromStr(NSString* str);



FOUNDATION_EXTERN void MSImageViewLoadContent(UIImageView* imageView, NSString* url, NSString* placeHolderName) ;
FOUNDATION_EXTERN void MSLoadHeadBoy(UIImageView* imageView, NSString* url) ;
FOUNDATION_EXTERN void MSLoadHeadGirl(UIImageView* imageView, NSString* url);

FOUNDATION_EXTERN NSMutableArray* AllocNotRetainedMutableArray();

@interface MSGlobal : NSObject

@end

//Images
#define MSHeadFemale     DZCachedImageByName(@"default_avater_lady.png")
#define MSHeadMale          DZCachedImageByName(@"default_avater_man.png")


//Realm
#define MSRLMDefaultStore [RLMRealm defaultRealm]
#define MSRLMBeginWrite   [MSRLMDefaultStore beginWriteTransaction];
#define MSRLMCommitWrite    [MSRLMDefaultStore commitWriteTransaction];