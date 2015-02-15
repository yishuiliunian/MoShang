//
//  MSLoginViewController.m
//  MoShang
//
//  Created by stonedong on 15/2/12.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSLoginViewController.h"
#import "QQSurroundLineTextField.h"
#import "UIButton+Custom.h"
#import <TTTAttributedLabel.h>
#import <MTStringAttributes.h>
#import <MTStringParser.h>
#import "MSRegisterReq.h"
#import "MSGuideUserInfoViewController.h"
#import "MSTipsPool.h"
#import "MSAlertPool.h"

@interface MSLoginViewController () <TTTAttributedLabelDelegate, MSRequestUIDelegate>
{
    QQSurroundLineTextField* _phonerNumberTextField;
    QQSurroundLineTextField* _passwordTextField;
    UIButton* _loginButton;
    
    TTTAttributedLabel* _contractLabel;
    TTTAttributedLabel* _headTitleLabel;
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
- (void) initAllViews
{
    QQSurroundLineTextField* (^CreateLineTextField)(NSString*name, NSString* placeHolder) = ^(NSString*name, NSString* placeHolder) {
        QQSurroundLineTextField* lineTextField = [QQSurroundLineTextField new];
        lineTextField.leftLabel.text = name;
        lineTextField.placeholder = placeHolder;
        lineTextField.leftLabelPrefix = 100;
        [self.scrollView addSubview:lineTextField];
        return lineTextField;
    };
    
    _phonerNumberTextField = CreateLineTextField(@"手机号码", @"请输入手机号码");
    _phonerNumberTextField.maxInputLength = 11;
    _passwordTextField = CreateLineTextField(@"密码", @"请输入密码");
    
    _loginButton = [UIButton CommonBlueButtonForTitle:@"登陆" target:self action:@selector(doLoginFromSender:)];
    [self.scrollView addSubview:_loginButton];
    
    _contractLabel = [[TTTAttributedLabel alloc] init];
    [self.scrollView addSubview:_contractLabel];
    _contractLabel.delegate = self;
    _contractLabel.textAlignment = UITextAlignmentCenter;
    
    
    NSString* contractPrefixStr = @"<normal>点击开始表示您同意</normal><action>陌上服务条款</action>";
    
    NSAttributedString* str = [[MTStringParser sharedParser] attributedStringFromMarkup:contractPrefixStr];
    _contractLabel.text = str;
    [_contractLabel addLinkToURL:[NSURL URLWithString:@"http://www.baidu.com"] withRange:[@"点击开始表示您同意陌上服务条款" rangeOfString:@"陌上服务条款"]];
    
    self.headTitleLabel.text = [[MTStringParser sharedParser] attributedStringFromMarkup:@"<tn>曾经  现在 \n 有一颗躁动的</tn><th1>心</th1><tn>需要安放</tn>"];
    
    
    
#ifdef DEBUG
   _phonerNumberTextField.text = @"18500040284";
    _passwordTextField.text = @"system32";
#endif
}
- (void) viewDidLoad
{
    [super viewDidLoad];
    [self initAllViews];
}

- (void) setAllControlEnable:(BOOL)enable
{
    _passwordTextField.enabled = enable;
    _phonerNumberTextField.enabled = enable;
    _loginButton.enabled = enable;
}

- (void) doLoginFromSender:(id)sender
{
    
//#ifdef DEBUG
//    MSGuideUserInfoViewController* guideVC = [MSGuideUserInfoViewController new];
//    [self.navigationController pushViewController:guideVC animated:YES];
//    return;
//#endif
    MSRegisterReq* registerReq = [MSRegisterReq new];
    registerReq.uidelegate = self;
    registerReq.password = _passwordTextField.text;
    registerReq.accountName = _phonerNumberTextField.text;
    registerReq.phoneNumber = _phonerNumberTextField.text;
    [MSDefaultSyncCenter performRequest:registerReq];
    
    [self setAllControlEnable:NO];
    
    [MSDefaultAlertPool showLoadingWithMessage:@"注册中...."];
}

- (void) request:(MSRequest *)request onError:(NSError *)error
{
    [self setAllControlEnable:YES];
    [MSDefaultTipsPool showError:error];
    
    [MSDefaultAlertPool hideAllAlert];
}

- (void) request:(MSRequest *)request onSucced:(id)object
{
    [self setAllControlEnable:YES];
    
    [MSDefaultAlertPool hideAllAlert];
}
- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.headTitleLabel.frame = CGRectMake(10, 20, CGRectGetWidth(self.view.bounds) - 20, 70);
    _phonerNumberTextField.frame = CGRectMake(0, CGRectGetMaxY(self.headTitleLabel.frame) + 10, CGRectGetWidth(self.view.bounds), 44);
    _passwordTextField.frame = CGRectMake(0, CGRectGetMaxY(_phonerNumberTextField.frame), CGRectGetWidth(self.view.bounds), 44);
    _contractLabel.frame = CGRectMake(10, CGRectGetMaxY(_passwordTextField.frame) + 20, CGRectGetWidth(self.view.bounds) - 20, 44);
    _loginButton.frame = CGRectMake(10, CGRectGetMaxY(_contractLabel.frame) + 20, CGRectGetWidth(self.view.bounds) - 20, 44);
}

#pragma mark -
- (void) attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url
{
    
}
@end
