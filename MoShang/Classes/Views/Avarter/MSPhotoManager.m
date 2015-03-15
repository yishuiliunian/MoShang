//
//  MSPhotoManager.m
//  MoShang
//
//  Created by stonedong on 15/3/15.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSPhotoManager.h"
#import "MSUploadImageManager.h"
#import "MSGlobal.h"
const int kMaxUploadImageCount = 5;

@interface MSPhotoManager () <MSUploadImageDelegate>
{
    NSMutableDictionary* _avaterInfos;
    NSMutableSet* _uploadKeys;
    
    NSMutableArray* _allAvaterKeys;
}
@end
@implementation MSPhotoManager
@synthesize uploadImageManager = _uploadImageManager;
- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _avaterInfos =[NSMutableDictionary new];
    _uploadKeys = [NSMutableSet new];
    return self;
}
- (void) uploadImageManger:(MSUploadImageManager *)manager uploadImageSucceed:(NSString *)key url:(NSString *)url
{
    [_avaterInfos setObject:url forKey:url];
    [_allAvaterKeys replaceObjectAtIndex:[_allAvaterKeys indexOfObject:key] withObject:url];
}

- (void) uploadImageManger:(MSUploadImageManager *)manager uploadImage:(NSString *)key faild:(NSError *)error
{
    
}

- (void)  loadArrays:(NSArray*)array
{
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    for (id object in array) {
        if ([object isKindOfClass:[NSString class]]) {
            [dic setObject:object forKey:object];
        }else if ([object isKindOfClass:[UIImage class]]) {
            [dic setObject:object forKey:MSGenRandomUUID()];
        }
    }
    _avaterInfos = dic;
    _allAvaterKeys = [dic.allKeys mutableCopy];
}

- (void) setPhotoArray:(NSArray *)photoArray
{
    [self loadArrays:photoArray];
    if([self.uiDelegate respondsToSelector:@selector(reloadData)])
    {
        [self.uiDelegate reloadData];
    }
}
- (MSUploadImageManager*) uploadImageManager
{
    if (!_uploadImageManager) {
        _uploadImageManager = [[MSUploadImageManager alloc] init];
        _uploadImageManager.delegate = self;
    }
    return _uploadImageManager;
}
- (void) addNeedUploadImage:(UIImage*)image
{
    NSString* key = MSGenRandomUUID();
    [_avaterInfos setObject:image forKey:key];
    [_allAvaterKeys addObject:key];
    if (_allAvaterKeys.count < kMaxUploadImageCount) {
        [self.uiDelegate insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:[_allAvaterKeys indexOfObject:key] inSection:0]]];
    } else {
        [self.uiDelegate reloadData];
    }
    [self.uploadImageManager uploadImage:image key:key];
}

- (int) count
{
    return _allAvaterKeys.count;
}

- (id) objectAtIndex:(NSInteger)index
{
    return _avaterInfos[_allAvaterKeys[index]];
}
- (NSArray*) photoArray
{
    return _allAvaterKeys;
}
@end
