//
//  MSAvarterCollectionViewController.h
//  MoShang
//
//  Created by stonedong on 15/3/3.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSAvarterCollectionViewController : UICollectionViewController
@property (nonatomic, assign, readonly) BOOL isUploading;
@property (nonatomic, strong, readonly) NSArray* avarters;
- (instancetype) initWithAvarters:(NSArray*)avarters itemSize:(CGSize)size;
@end
