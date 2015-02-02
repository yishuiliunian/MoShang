//
//  MSLayout.h
//  MoShang
//
//  Created by stonedong on 15/1/27.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MSLayoutProtocol.h"
@interface MSLayout : NSObject
{
    CGSize _size;
    NSMutableArray* __subLayouts;
}
@property (nonatomic, assign, readonly) CGSize size;
@property (nonatomic, strong, readonly) NSArray* subLayouts;
@property (nonatomic, strong, readonly) MSLayout* superLayout;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@property (nonatomic, assign) CGFloat subLayoutSpace;
@property (nonatomic, strong) UIView<MSLayoutProtocol>* layoutView;
- (void) addSubLayout:(MSLayout*)layout;
- (void) removeFromSuperLayout;


- (void) recalculateSize;

- (void) layout;
@end
