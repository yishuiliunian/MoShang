//
//  MSSetAvatarViewController.m
//  MoShang
//
//  Created by stonedong on 15/2/13.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSSetAvatarViewController.h"
#import "UIButton+Custom.h"
#import <DZProgramDefines.h>
#import "MSChoceProviceViewController.h"
@interface MSSetAvatarViewController ()
{
    UIImageView* _guidImageView;
    UIButton* _avatarButton;
}
@end

@implementation MSSetAvatarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    INIT_SUBVIEW(self.view, UIImageView, _guidImageView);
    _avatarButton = [UIButton CommonBlueButtonForTitle:@"设置头像" target:self action:@selector(setAvatar)];
    [self.view addSubview:_avatarButton];
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
#ifdef DEBUG
    [self nextStep];
#endif
}
- (void) nextStep
{
    MSChoceProviceViewController* vc = [MSChoceProviceViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void) setAvatar
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (void) viewWillLayoutSubviews
{
    CGSize imageSize = CGSizeMake(199, 199);
    self.headTitleLabel.frame = CGRectMake(10, 0, CGRectGetViewControllerWidth - 20, 100);
    _guidImageView.frame = CGRectMake(0, CGRectGetMaxY(self.headTitleLabel.frame), imageSize.width, imageSize.height);
    _avatarButton.frame = CGRectMake(10, CGRectGetMaxY(_guidImageView.frame), CGRectGetViewControllerWidth - 20, 44);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
