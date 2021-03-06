//
//  MSInputScrollViewController.m
//  MoShang
//
//  Created by stonedong on 15/2/12.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSInputScrollViewController.h"
#import <DZGeometryTools.h>
@implementation MSInputScrollViewController
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!self) {
        return self;
    }
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordWillHide:) name:UIKeyboardWillHideNotification object:nil];
    return self;
}
- (void) keybordWillShow:(NSNotification*)nc
{
    CGRect rect = [nc.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect scrollRect = self.view.bounds;
    scrollRect.size.height = CGRectGetHeight(self.view.bounds) - rect.size.height;
    _scrollView.frame = scrollRect;
}

- (void) keybordWillHide:(NSNotification*)nc
{
    CGRect scrollRect = self.view.bounds;
    _scrollView.frame = scrollRect;
}
- (void) viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_scrollView];
    _scrollView.contentSize = self.view.bounds.size;
    
    UITapGestureRecognizer* tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleHideKeyboardTap:)];
    tapG.numberOfTapsRequired = 1;
    tapG.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:tapG];
    
    
    _headTitleLabel = [TTTAttributedLabel new];
    _headTitleLabel.numberOfLines = 0;
    _headTitleLabel.textAlignment = UITextAlignmentCenter;
    [self.scrollView addSubview:_headTitleLabel];
}

- (void) handleHideKeyboardTap:(UITapGestureRecognizer*)tapG
{
    if (tapG.state == UIGestureRecognizerStateRecognized) {
        NSArray* subViews = self.scrollView.subviews;
        CGPoint point = [tapG locationInView:self.scrollView];
        for (UIView* v in subViews) {
            if (CGRectContainsPoint(v.frame, point)) {
                return;
            }
        }
        
        for (UIView* v in subViews) {
            if ([v respondsToSelector:@selector(resignFirstResponder)]) {
                [v resignFirstResponder];
            }
        }
    }
}
@end
