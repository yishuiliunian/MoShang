//
//  MSAvarterCollectionViewController.h
//  MoShang
//
//  Created by stonedong on 15/3/3.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSUploadImageManager.h"
#import "MSPhotoManager.h"
@interface MSAvarterCollectionViewController : UICollectionViewController
@property (nonatomic, assign, readonly) BOOL isUploading;
@property (nonatomic, strong, readonly) NSArray* avarters;
@property (nonatomic, assign) BOOL canAddPhoto;
@property (nonatomic, strong, readonly) MSUploadImageManager* uploadImageManager;
@property (nonatomic, strong, readonly) MSPhotoManager* photoManager;
- (instancetype) initWithAvarters:(NSArray*)avarters itemSize:(CGSize)size;
- (void) setPhotos:(NSArray*)array;
@end
