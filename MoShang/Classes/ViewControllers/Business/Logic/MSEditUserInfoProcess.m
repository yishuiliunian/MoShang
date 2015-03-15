//
//  MSEditUserInfoProcess.m
//  MoShang
//
//  Created by stonedong on 15/3/15.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSEditUserInfoProcess.h"
#import "MSSetUserInfoReq.h"
@interface MSEditUserInfoProcess () <MSUploadImageDelegate, MSRequestUIDelegate>
@property (nonatomic, strong) NSString* uploadAvatarKey;
@property (nonatomic, assign) BOOL avatarReady;
@property (nonatomic, strong) MSEditUserInfoCompleteBlock completeBlock;
@end
@implementation MSEditUserInfoProcess
@synthesize uploadImageManager = _uploadImageManager;
@synthesize userInfo = _userInfo;

- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _isReady = NO;
    _avatarReady = NO;
    return self;
}

- (MSUploadImageManager*) uploadImageManager
{
    if (!_uploadImageManager) {
        _uploadImageManager = [[MSUploadImageManager alloc] init];
        _uploadImageManager.delegate = self;
    }
    return _uploadImageManager;
}

- (MSUserInfo*) userInfo
{
    if (!_userInfo) {
        _userInfo = [MSUserInfo new];
    }
    return _userInfo;
}

- (void) uploadAvatar:(UIImage*)image
{
    self.uploadAvatarKey = @"xxx";
    [self.uploadImageManager uploadImage:image key:self.uploadAvatarKey];
    _avatarReady = NO;
}
- (void) uploadImageManger:(MSUploadImageManager *)manager uploadImageSucceed:(NSString *)key url:(NSString *)url
{
    if ([key isEqualToString:self.uploadAvatarKey]) {
        _avatarReady = YES;
        _userInfo.head = url;
    }
}

- (void) forceUpload:(MSEditUserInfoCompleteBlock)block
{
    MSSetUserInfoReq* setUserInfoReq = [MSSetUserInfoReq new];
    setUserInfoReq.userInfo = self.userInfo;
    setUserInfoReq.uidelegate = self;
    self.completeBlock = block;
    [MSDefaultSyncCenter performRequest:setUserInfoReq];
}

- (void) request:(MSRequest *)request onError:(NSError *)error
{
    if (self.completeBlock) {
        self.completeBlock(error);
    }
    [self.delegate logicProcess:self finishedScucceed:NO error:error];
}

- (void) request:(MSRequest *)request onSucced:(id)object
{
    if (self.completeBlock) {
        self.completeBlock(nil);
    }
    [self.delegate logicProcess:self finishedScucceed:YES error:nil];
}
@end
