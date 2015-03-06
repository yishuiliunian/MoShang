//
//  DZTabViewItem.h
//  Pods
//
//  Created by stonedong on 15/3/5.
//
//

#import <UIKit/UIKit.h>

@interface DZTabViewItem : UIView
@property (nonatomic, assign, readonly) BOOL isSelected;
@property (nonatomic, strong, readonly) UILabel* textLabel;
@property (nonatomic, strong, readonly) UIImageView* imageView;
@property (nonatomic, strong) UIView* contentView;
@end
