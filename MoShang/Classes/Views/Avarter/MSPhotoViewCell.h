//
//  MSPhotoViewCell.h
//  MoShang
//
//  Created by stonedong on 15/3/3.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DZProgramDefines.h>
#import "MSLayoutEngine.h"
@interface MSPhotoViewCell : UICollectionViewCell
DEFINE_PROPERTY_STRONG_UIImageView(photoImageView);
@property (nonatomic, assign) BOOL isFirst;
@end
