//
//  MSProviceView.h
//  MoShang
//
//  Created by stonedong on 15/2/10.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MSProviceView;
@interface MSProvice : NSObject
@property (nonatomic, weak) MSProviceView* view;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong, readonly) UIImage* image;
@property (nonatomic, strong, readonly) UIImage* hightlightImage;
@property (nonatomic, assign) CGRect scaleRect;
- (instancetype) initWithProviceImage:(NSString*)name highlightImage:(NSString*)name scaleRect:(CGRect)scaleRect;
@end


@interface MSProviceView : UIImageView
@property (nonatomic, strong) MSProvice* province;
@property (nonatomic, assign) BOOL selected;
@end
