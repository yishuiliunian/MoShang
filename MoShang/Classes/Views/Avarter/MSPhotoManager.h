//
//  MSPhotoManager.h
//  MoShang
//
//  Created by stonedong on 15/3/15.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSUploadImageManager.h"
@interface MSPhotoManager : NSObject
@property (nonatomic, weak) id uiDelegate;
@property (nonatomic, strong, readonly) MSUploadImageManager* uploadImageManager;
@property (nonatomic, strong, readonly) NSArray* photoArray;
@property (nonatomic, assign, readonly) int count;
- (void) setPhotoArray:(NSArray *)photoArray;
- (id) objectAtIndex:(NSInteger)index;
- (void) addNeedUploadImage:(UIImage*)image;
@end
