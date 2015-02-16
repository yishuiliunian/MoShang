//
//  MSChoceProviceViewController.m
//  MoShang
//
//  Created by stonedong on 15/2/13.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSChoceProviceViewController.h"
#import "MSChinaMap.h"
#import "MSLabelProviceCollectionViewController.h"
@interface MSChoceProviceViewController ()
{
    MSLabelProviceCollectionViewController* _provicesCollectionVC;
}
@property (nonatomic, strong, readonly) MSChinaMap* chinaMap;
@end

@implementation MSChoceProviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _chinaMap = [MSChinaMap new];
    [self.scrollView addSubview:_chinaMap];
    
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(75, 30);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _provicesCollectionVC = [[MSLabelProviceCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
    [_provicesCollectionVC willMoveToParentViewController:self];
    [self addChildViewController:_provicesCollectionVC];
    [self.scrollView addSubview:_provicesCollectionVC.view];
    [_provicesCollectionVC didMoveToParentViewController:self];
    
    _provicesCollectionVC.chinaMap = self.chinaMap;
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
    _provicesCollectionVC.view.frame = CGRectMake(10, CGRectGetMaxY(_chinaMap.frame), CGRectGetViewControllerWidth - 20, 90);
}

@end
