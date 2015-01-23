//
//  MSGlobalNavViewController.m
//  MoShang
//
//  Created by stonedong on 15/1/23.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSGlobalNavViewController.h"
#import "MSMainViewController.h"
@interface MSGlobalNavViewController ()
@end

@implementation MSGlobalNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MSMainViewController* mainVC = [MSMainViewController new];
    
    [self ms_AddChildViewController:mainVC];
    _mainViewController = mainVC;
    // Do any additional setup after loading the view.
}

- (void) ms_AddChildViewController:(UIViewController*)viewController
{
    [viewController willMoveToParentViewController:self];
    
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    viewController.view.frame = self.view.bounds;
    [viewController didMoveToParentViewController:self];
}


- (void) ms_removeChildViewController:(UIViewController*)vc
{
    [vc willMoveToParentViewController:nil];
    [vc removeFromParentViewController];
    [vc.view removeFromSuperview];
    [vc didMoveToParentViewController:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
