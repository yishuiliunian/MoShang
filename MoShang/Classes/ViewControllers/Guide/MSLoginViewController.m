//
//  MSLoginViewController.m
//  MoShang
//
//  Created by stonedong on 15/2/12.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSLoginViewController.h"
#import "QQSurroundLineTextField.h"
@interface MSLoginViewController ()
{
    QQSurroundLineTextField* _phonerNumberTextField;
    QQSurroundLineTextField* _passwordTextField;
}
@end
@implementation MSLoginViewController

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!self) {
        return self;
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    QQSurroundLineTextField* (^CreateLineTextField)(NSString*name, NSString* placeHolder) = ^(NSString*name, NSString* placeHolder) {
        QQSurroundLineTextField* lineTextField = [QQSurroundLineTextField new];
        lineTextField.leftLabel.text = name;
        lineTextField.placeholder = placeHolder;
        lineTextField.leftLabelPrefix = 100;
        [self.scrollView addSubview:lineTextField];
        return lineTextField;
    };
    
    _phonerNumberTextField = CreateLineTextField(@"手机号码", @"请输入手机号码");
    _passwordTextField = CreateLineTextField(@"密码", @"请输入密码");
    
}

- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _phonerNumberTextField.frame = CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), 44);
    _passwordTextField.frame = CGRectMake(0, CGRectGetMaxY(_phonerNumberTextField.frame), CGRectGetWidth(self.view.bounds), 44);
}
@end
