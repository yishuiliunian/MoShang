//
//  MSUploadImageManager.h
//  MoShang
//
//  Created by stonedong on 15/3/15.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MSUploadImageManager;
@protocol MSUploadImageDelegate <NSObject>

- (void) uploadImageManger:(MSUploadImageManager*)manager uploadImage:(NSString*)key faild:(NSError*)error;
- (void) uploadImageManger:(MSUploadImageManager*)manager uploadImageSucceed:(NSString*)key url:(NSString*)url;
@optional
- (void) uploadImageManger:(MSUploadImageManager *)manager beginUploadImage:(NSString *)key;
- (void) uploadImageManger:(MSUploadImageManager *)manager uploadImage:(NSString*)key process:(float)process;
- (void) uploadImageManger:(MSUploadImageManager *)manager totalProcess:(float)process;
@end
@interface MSUploadImageManager : NSObject
@property (nonatomic, weak) id<MSUploadImageDelegate> delegate;
@property (nonatomic, assign, readonly) NSInteger uploadingCount;
@property (nonatomic, assign, readonly) BOOL isUploading;
- (void) uploadImage:(UIImage*)image key:(NSString*)inKey;

- (void) addUploadImageObserver:(id<MSUploadImageDelegate>)oberver;
- (void) removeUploadImageObserver:(id<MSUploadImageDelegate>)observer;
@end
