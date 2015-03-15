//
//  MSEditUserInfoProcess.h
//  MoShang
//
//  Created by stonedong on 15/3/15.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSUILogicProcess.h"
#import "MSUserInfo.h"
#import "MSUploadImageManager.h"
typedef void (^MSEditUserInfoCompleteBlock)(NSError* error);
@interface MSEditUserInfoProcess : MSUILogicProcess
@property (nonatomic, assign, readonly) BOOL isReady;
@property (nonatomic, strong, readonly) MSUserInfo* userInfo;
@property (nonatomic, strong, readonly) MSUploadImageManager* uploadImageManager;
- (void) uploadAvatar:(UIImage*)image;
- (void) forceUpload:(MSEditUserInfoCompleteBlock)block;
@end
