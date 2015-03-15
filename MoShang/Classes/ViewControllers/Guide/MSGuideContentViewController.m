//
//  MSGuideContentViewController.m
//  MoShang
//
//  Created by stonedong on 15/2/13.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSGuideContentViewController.h"
#import "MSLoginViewController.h"
#import "MSUILogicManager.h"

@implementation UIViewController (MSGuideContentViewController)

- (MSGuideContentViewController*) guideContentViewController
{
    if ([self.navigationController isKindOfClass:[MSGuideContentViewController class]]) {
        return (MSGuideContentViewController*)self.navigationController;
    }
    return nil;
}

@end

@interface MSGuideContentViewController ()

@end

@implementation MSGuideContentViewController
@synthesize editUserProcess = _editUserProcess;
- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!self) {
        return self;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self pushViewController:[MSLoginViewController new] animated:NO];
    // Do any additional setup after loading the view.
}
- (MSEditUserInfoProcess*)editUserProcess
{
    if (!_editUserProcess) {
        _editUserProcess = [MSEditUserInfoProcess new];
        [[MSUILogicManager shareManager] addLogicProcess:_editUserProcess];
    }
    return _editUserProcess;
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
