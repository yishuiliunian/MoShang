//
//  MSCreateFeedViewController.m
//  MoShang
//
//  Created by stonedong on 15/1/23.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSCreateFeedViewController.h"

@interface MSCreateFeedViewController ()

@end

@implementation MSCreateFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem* barItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(dismissNavigationController)];
    self.navigationItem.rightBarButtonItem =barItem;
    // Do any additional setup after loading the view.
}

- (void) dismissNavigationController
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
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
