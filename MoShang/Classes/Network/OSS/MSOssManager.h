//
//  MSOssManager.h
//  MoShang
//
//  Created by stonedong on 15/3/3.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
extern NSString* const kDZOssAceessKey;
extern NSString* const kDZOssScretKey;

@class OSSData;
@protocol MSOssUploadObserver <NSObject>

- (void) uploadImageSucceed:(UIImage*)image withKey:(NSString*)key url:(NSString*)url;
- (void) uploadImageWithKey:(NSString *)key faild:(NSError*)error;
@optional
- (void) uploadImageWithKey:(NSString *)key process:(float)process;
@end

#define MSShareOssManager [MSOssManager shareManager]
typedef void(^MSOssUploadFnishedBlock)(NSString* url, NSError* error);
@interface MSOssManager : NSObject
+ (MSOssManager*) shareManager;

- (void) addUploadImageObserver:(id<MSOssUploadObserver>)oberver;
- (void) removeUploadImageObserver:(id<MSOssUploadObserver>)observer;

- (void) uploadImage:(UIImage*)image key:(NSString*)key;

@end
