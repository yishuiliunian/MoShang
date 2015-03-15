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
@interface MSGuideUserInfoViewController () < UITextFieldDelegate>
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
        lineTextField.delegate = self;
        [self.scrollView addSubview:lineTextField];
        return lineTextField;
    };
    
    _nickNameTextField = CreateLineTextField(@"昵称", @"一朵小花");
    _birthDayTextField = CreateLineTextField(@"生日", @"1990.06.06");
    _birthDayTextField.enabled = YES;
    //
    _datePicker = [[UIDatePicker alloc]init];
    // 時區的問題請再找其他協助 不是本篇重點
    NSLocale* datelocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_TW"];
    _datePicker.locale = datelocale;
    _datePicker.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _birthDayTextField.inputView = _datePicker;
    [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    //
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self
                                                                          action:@selector(cancelPicker)];
    toolBar.items = [NSArray arrayWithObjects:right, nil];
    _birthDayTextField.inputAccessoryView = toolBar;
    
    _nextStepButton = [UIButton CommonBlueButtonForTitle:@"下一步" target:self action:@selector(nextSetp)];
    [self.scrollView addSubview:_nextStepButton];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//#ifdef DEBUG
//    [self nextSetp];
//#endif
}
- (void) changeBirthDay
{

}
- (void) nextSetp
{
    MSSetAvatarViewController* avatarVC = [MSSetAvatarViewController new];
    [self.navigationController pushViewController:avatarVC animated:YES];
    self.guideContentViewController.editUserProcess.userInfo.birth = _birthDayTextField.text;
    self.guideContentViewController.editUserProcess.userInfo.nick = _nickNameTextField.text;
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
}



- (void) datePickerValueChanged:(id)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSString *dateFormat = [NSDateFormatter dateFormatFromTemplate:@"yyyy-MM-dd" options:0 locale:_datePicker.locale];
    [formatter setDateFormat:dateFormat];
    [formatter setLocale:_datePicker.locale];
    _birthDayTextField.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:_datePicker.date]];
    
}
-(void) cancelPicker {

    if ([self.view endEditing:NO]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    }
}

@end
