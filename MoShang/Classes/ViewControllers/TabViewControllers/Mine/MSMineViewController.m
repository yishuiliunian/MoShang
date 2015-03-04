//
//  MSMineViewController.m
//  MoShang
//
//  Created by stonedong on 15/1/23.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSMineViewController.h"
#import "MSMineTopView.h"
#import "MSAvarterCollectionViewController.h"
@interface MSMineViewController ()
{
    MSAvarterCollectionViewController* _avarterVC;
}
@end

@implementation MSMineViewController

- (void) ms_addChildViewController:(UIViewController*)vc
{
    [vc willMoveToParentViewController:self];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    [vc didMoveToParentViewController:self];
}
- (void) initUIControls
{
    _avarterVC = [[MSAvarterCollectionViewController alloc] initWithAvarters:@[@"http://img1.mydrivers.com/img/20141014/46769b2731584375a308d455000bce3b.jpg",
                                                                               @"http://img1.mydrivers.com/img/20141014/46769b2731584375a308d455000bce3b.jpg",
                                                                               @"http://img1.mydrivers.com/img/20141014/46769b2731584375a308d455000bce3b.jpg",
                                                                               @"http://img1.mydrivers.com/img/20141014/46769b2731584375a308d455000bce3b.jpg"]
                                                                    itemSize:CGSizeMake(100, 100)];
    
    [self ms_addChildViewController:_avarterVC];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self initUIControls];
    
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _avarterVC.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame)/4 + 30);
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
