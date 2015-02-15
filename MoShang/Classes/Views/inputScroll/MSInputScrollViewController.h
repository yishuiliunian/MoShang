//
//  MSInputScrollViewController.h
//  MoShang
//
//  Created by stonedong on 15/2/12.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TTTAttributedLabel.h>
#import <MTStringParser.h>
#import <DZGeometryTools.h>
@interface MSInputScrollViewController : UIViewController
@property (nonatomic, strong, readonly) UIScrollView* scrollView;
@property (nonatomic, strong, readonly) TTTAttributedLabel* headTitleLabel;
@end
