//
//  MSProvinceCollectionViewCell.h
//  MoShang
//
//  Created by stonedong on 15/2/15.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LKBadgeView.h>
@interface MSProvinceCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong, readonly) LKBadgeView* badgeView;
@property (nonatomic, assign) BOOL mapSelected;
@end
