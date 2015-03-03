//
//  MSGuideUserInfoViewController.m
//  MoShang
//
//  Created by stonedong on 15/2/13.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSGuideUserInfoViewController.h"
#import "QQSurroundLineTextField.h"
#import "UIButton+Custom.h"
#import "MSSetAvatarViewController.h"
#import "MSGuideContentViewController.h"
#import <THCalendarDatePicker/THDatePickerViewController.h>
@interface MSGuideUserInfoViewController () <THDatePickerDelegate>
{
    QQSurroundLineTextField* _nickNameTextField;
    QQSurroundLineTextField* _birthDayTextField;
    
    UIButton* _nextStepButton;
    
    UIButton* _birthdayButton;
}
@property (nonatomic, strong) UIDatePicker* datePicker;
@end

@implementation MSGuideUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    QQSurroundLineTextField* (^CreateLineTextField)(NSString*name, NSString* placeHolder) = ^(NSString*name, NSString* placeHolder) {
        QQSurroundLineTextField* lineTextField = [QQSurroundLineTextField new];
        lineTextField.leftLabel.text = name;
        lineTextField.placeholder = placeHolder;
        lineTextField.leftLabelPrefix = 100;
        [self.scrollView addSubview:lineTextField];
        return lineTextField;
    };
    
    _nickNameTextField = CreateLineTextField(@"昵称", @"一朵小花");
    _birthDayTextField = CreateLineTextField(@"生日", @"1990.06.06");
    
    _birthDayTextField.enabled = YES;
    
    _birthdayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_birthdayButton addTarget:self action:@selector(changeBirthDay) forControlEvents:UIControlEventTouchUpInside];
    [_birthDayTextField addSubview:_birthdayButton];
    
    _nextStepButton = [UIButton CommonBlueButtonForTitle:@"下一步" target:self action:@selector(nextSetp)];
    [self.scrollView addSubview:_nextStepButton];
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
#ifdef DEBUG
    [self nextSetp];
#endif
}
- (void) changeBirthDay
{
    
}
- (void) nextSetp
{
    MSSetAvatarViewController* avatarVC = [MSSetAvatarViewController new];
    [self.navigationController pushViewController:avatarVC animated:YES];
    self.guideContentViewController.userInfo.birth = _birthDayTextField.text;
    self.guideContentViewController.userInfo.nick = _nickNameTextField.text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillLayoutSubviews
{
    self.headTitleLabel.frame = CGRectMake(10, 10, CGRectGetViewControllerWidth, 100);
    _nickNameTextField.frame = CGRectMake(0, CGRectGetMaxY(self.headTitleLabel.frame), CGRectGetViewControllerWidth, 44);
    _birthDayTextField.frame = CGRectMake(0, CGRectGetMaxY(_nickNameTextField.frame), CGRectGetViewControllerWidth, 44);
    _nextStepButton.frame = CGRectMake(10, CGRectGetMaxY(_birthDayTextField.frame) + 40, CGRectGetViewControllerWidth - 20, 44);
    
    _birthdayButton.frame = _birthDayTextField.bounds;
}


- (void) datePicker:(THDatePickerViewController *)datePicker selectedDate:(NSDate *)selectedDate
{
    
}
- (void) datePickerCancelPressed:(THDatePickerViewController *)datePicker
{
    
}

- (void) datePickerDonePressed:(THDatePickerViewController *)datePicker
{
    
}

@end
