//
//  MSUploadImageManager.m
//  MoShang
//
//  Created by stonedong on 15/3/15.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSUploadImageManager.h"
#import <DZProgramDefines.h>
#import "MSOssManager.h"
#import "MSGlobal.h"
#import <Haneke.h>
DEFINE_NSString(UploadKeyPrefix)
NSString* MS_UploadKey(NSString* key)
{
    return [NSString stringWithFormat:@"%@%@", kDZUploadKeyPrefix, key];
}

int MS_IndexFromUploadKey(NSString*key) {
    NSString* index = [key stringByReplacingOccurrencesOfString:kDZUploadKeyPrefix withString:@""];
    return [index intValue];
}


@interface MSUploadImageManager () <MSOssUploadObserver>
{
    NSMutableArray* _uploadKeys;
    NSMutableArray* _delegateArray;
    
    NSMutableDictionary* _uploadProcessMap;
}
@end
@implementation MSUploadImageManager

- (void) dealloc
{
    [MSShareOssManager removeUploadImageObserver:self];
}

- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _uploadKeys = [NSMutableArray new];
    _delegateArray = AllocNotRetainedMutableArray();
    _uploadProcessMap = [NSMutableDictionary new];
    [MSShareOssManager addUploadImageObserver:self];
    return self;
}

- (void) addUploadImageObserver:(id<MSOssUploadObserver>)oberver
{
    if (![_delegateArray containsObject:oberver]) {
        [_delegateArray addObject:oberver];
    }
}

- (void) removeUploadImageObserver:(id<MSOssUploadObserver>)observer
{
    [_delegateArray removeObject:observer];
}

- (void) uploadImage:(UIImage*)image key:(NSString*)key
{
    [_uploadKeys addObject:key];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       [[MSOssManager shareManager] uploadImage:image key:key];
        dispatch_async(dispatch_get_main_queue(), ^{
            for (id<MSUploadImageDelegate> ob in _delegateArray) {
                if ([ob respondsToSelector:@selector(uploadImageManger:beginUploadImage:)]) {
                    [ob uploadImageManger:self beginUploadImage:key];
                }
            }
            if ([self.delegate respondsToSelector:@selector(uploadImageManger:beginUploadImage:)]) {
                [self.delegate uploadImageManger:self beginUploadImage:key];
            }
        });
    });
}

- (void) uploadImageWithKey:(NSString *)key faild:(NSError *)error
{
    if ([_uploadKeys containsObject:key]) {
        [_uploadKeys removeObject:key];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.delegate respondsToSelector:@selector(uploadImageManger:uploadImage:faild:)]) {
                [self.delegate uploadImageManger:self uploadImage:key faild:error];
            }
            for (id<MSUploadImageDelegate> ob in _delegateArray) {
                if ([ob respondsToSelector:@selector(uploadImageManger:uploadImage:faild:)]) {
                    [ob uploadImageManger:self uploadImage:key faild:error];
                }
            }

        });

    }
}

- (void)uploadImageSucceed:(UIImage *)image withKey:(NSString *)key url:(NSString *)url
{
    [[HNKCache sharedCache] setImage:image forKey:url formatName:MSFormatFeedBackground.name];
    [[HNKCache sharedCache] setImage:image forKey:url formatName:MSFormatPhotoLittle.name];
    if ([_uploadKeys containsObject:key]) {
        [_uploadKeys removeObject:key];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.delegate respondsToSelector:@selector(uploadImageManger:uploadImageSucceed:url:)]) {
                [self.delegate uploadImageManger:self uploadImageSucceed:key url:url];
            }
            for (id<MSUploadImageDelegate> ob in _delegateArray) {
                if ([ob respondsToSelector:@selector(uploadImageManger:uploadImageSucceed:url:)]) {
                    [ob uploadImageManger:self uploadImageSucceed:key url:url];
                }
            }

        });

    }
}

- (void) uploadImageWithKey:(NSString *)key process:(float)process
{
    [self setUploadImage:key process:process];
    dispatch_async(dispatch_get_main_queue(), ^{
        for (id<MSUploadImageDelegate> ob in _delegateArray) {
            if ([ob respondsToSelector:@selector(uploadImageManger:uploadImage:process:)]) {
                [ob uploadImageManger:self uploadImage:key process:process];
            }
            if ([ob respondsToSelector:@selector(uploadImageManger:totalProcess:)]) {
                [ob uploadImageManger:self totalProcess:[self totalProcess]];
            }
        }
        if ([self.delegate respondsToSelector:@selector(uploadImageManger:uploadImage:process:)]) {
            [self.delegate uploadImageManger:self uploadImage:key process:process];
        }
        if ([self.delegate respondsToSelector:@selector(uploadImageManger:totalProcess:)]) {
            [self.delegate uploadImageManger:self totalProcess:[self totalProcess]];
        }
    });
}

- (float) processForKey:(NSString*)key
{
    return [_uploadProcessMap[key] floatValue];
}

- (void) setUploadImage:(NSString*)key process:(float)process
{
    if (key) {
        _uploadProcessMap[key] = @(process);
    }
}

- (void) removeUploadProcess:(NSString*)key
{
    return [_uploadProcessMap removeObjectForKey:key];
}

- (float) totalProcess
{
    if (_uploadKeys.count == 0) {
        return 1.0;
    }
    float sum = 0;
    for (NSString* key  in _uploadKeys) {
        sum += [self processForKey:key];
    }
    return sum/_uploadKeys.count;
}
- (NSInteger) uploadingCount
{
    return [_uploadKeys count];
}

- (BOOL) isUploading
{
    return [_uploadKeys count] != 0;
}
@end
