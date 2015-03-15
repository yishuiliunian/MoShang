//
//  MSCreateFeedProcess.m
//  MoShang
//
//  Created by stonedong on 15/3/15.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSCreateFeedProcess.h"
#import "MSPostFeedReq.h"
#import "MSLocationManager.h"
#import "NSError+MS.h"
@interface MSCreateFeedProcess () <MSUploadImageDelegate, MSRequestUIDelegate>

@end

@implementation MSCreateFeedProcess

- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _photoReady = NO;
    _content = NO;
    return self;
}

- (void) setPhotoManager:(MSPhotoManager *)photoManager
{
    if (_photoManager != photoManager) {
        [_photoManager.uploadImageManager removeUploadImageObserver:self];
        _photoManager = photoManager;
        [_photoManager.uploadImageManager addUploadImageObserver:self];
    }
}
- (BOOL) setContent:(NSString *)content error:(NSError *__autoreleasing *)error
{
    if (_content != content) {
        if (content == nil || content.length ==0) {
            if (error != NULL) {
                *error = [NSError ms_errorWithMessage:@"亲最起码写点什么吧" code:-99];
            }
            return NO;
        }
        _content = content;
        return YES;
    }
    return YES;
}

- (void) uploadImageManger:(MSUploadImageManager *)manager uploadImage:(NSString *)key faild:(NSError *)error
{
    _photoReady = !manager.isUploading;
    [self tryPost];
}

- (void) uploadImageManger:(MSUploadImageManager *)manager uploadImageSucceed:(NSString *)key url:(NSString *)url
{
    _photoReady = !manager.isUploading;
    [self tryPost];
}
- (void)  forcePost
{
    NSString* picList = [NSString new];
    NSArray* images = self.photoManager.photoArray;
    for (NSString* a in images) {
        if ([a isKindOfClass:[NSString class]]) {
            if (![a hasPrefix:@"http"]) {
                continue;
            }
            picList =  [picList stringByAppendingFormat:@"%@;", a];
        }
    }
    MSPostFeedReq* postReq = [MSPostFeedReq new];
    postReq.content = self.content;
    postReq.piclist = picList;
    postReq.backgroundColor = self.backgroundColor;
    postReq.position = [MSLocationManager shareManager].currentLocation.serverEncodeString;
    postReq.uidelegate = self;
    [MSDefaultSyncCenter performRequest:postReq];
}
- (void) tryPost
{
    [self post];
}
- (void) post
{
    if (_content && _photoReady) {
        [self forcePost];
    }
}

- (void) request:(MSRequest *)request onError:(NSError *)error
{
    
}

- (void) request:(MSRequest *)request onSucced:(id)object
{
    [self.delegate logicProcess:self finishedScucceed:YES error:nil];
}
@end
