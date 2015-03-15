//
//  MSOssManager.m
//  MoShang
//
//  Created by stonedong on 15/3/3.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSOssManager.h"
#import <DZSingletonFactory.h>
#import "OSSBucket.h"
#import "OSSData.h"
#import "MSGlobal.h"







NSString* const kDZOssAceessKey = @"tbGvfkR7RkGBi7Mw";
NSString* const kDZOssScretKey = @"ZJQXjHz90Ez9cOPQjRzC8hFoh9nNLW";
@interface MSOssManager ()
@property (nonatomic, strong, readonly) OSSBucket* picturesBucket;
@end

@interface MSOssManager ()
{
    NSMutableArray* _delegateArray;
}
@end

@implementation MSOssManager
@synthesize picturesBucket = _picturesBucket;
+ (MSOssManager*) shareManager
{
    return DZSingleForClass([self class]);
}

- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _delegateArray = AllocNotRetainedMutableArray();
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

- (OSSBucket*) picturesBucket
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _picturesBucket = [[OSSBucket alloc] initWithBucket:@"ms-pictures"];
    });
    return _picturesBucket;
}


- (void) uploadImage:(UIImage*) image key:(NSString *)key {
    NSData* data = UIImageJPEGRepresentation(image, 0.6);
    NSString* urlKey = MSGenerateRandomUUID;
    OSSData* ossData = [[OSSData alloc] initWithBucket:self.picturesBucket withKey:urlKey];
    [ossData setData:data withType:@"jpeg"];
    NSString* url = [ossData getResourceURL];
    __weak OSSData* weakData = ossData;
    [ossData uploadWithUploadCallback:^(BOOL y, NSError * error) {
        
        NSString* u = [weakData getResourceURL:kDZOssAceessKey andExpire:100000000000];
        for (id<MSOssUploadObserver> ob in _delegateArray) {
            if (y) {
                [ob  uploadImageSucceed:image withKey:key url:u];
            } else {
                [ob uploadImageWithKey:key faild:error];
            }
        }
        
    } withProgressCallback:^(float x) {
        NSLog(@"upload process %f",x);
    }];
}
@end
