//
//  MSChoceProviceViewController.m
//  MoShang
//
//  Created by stonedong on 15/2/13.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSChoceProviceViewController.h"
#import "MSChinaMap.h"
@interface MSChoceProviceViewController ()
@property (nonatomic, strong, readonly) MSChinaMap* chinaMap;
@end

@implementation MSChoceProviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _chinaMap = [MSChinaMap new];
    [self.scrollView addSubview:_chinaMap];
    // Do any additional setup after loading the view.
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

- (void) viewWillLayoutSubviews
{
    self.headTitleLabel.frame = CGRectMake(10, 10, CGRectGetViewControllerWidth, 100);
    _chinaMap.frame = CGRectMake(0, CGRectGetMaxY(self.headTitleLabel.frame), CGRectGetViewControllerWidth, 320);
}

@end
