//
//  MSLayoutItem.h
//  MoShang
//
//  Created by stonedong on 15/1/27.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MSLayoutItem : NSObject
{
    CGSize _layoutSize;
}
@property (nonatomic, assign) UIEdgeInsets egdeInsets;
@property (nonatomic, assign) CGSize layoutSize;
@property (nonatomic, assign) CGRect frame;
@end
