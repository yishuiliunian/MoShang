//
//  MSCreateFeedViewController.m
//  MoShang
//
//  Created by stonedong on 15/1/23.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSCreateFeedViewController.h"
#import "MSAvarterCollectionViewController.h"
#import <DZProgramDefines.h>
#import <DZGeometryTools.h>
#import "MSGlobal.h"
#import "MSPostFeedReq.h"
#import "MSAlertPool.h"
#import "MSLocationManager.h"
#import <MRProgress.h>
#import "MSCreateFeedProcess.h"
#import "MSUILogicManager.h"
@interface MSCreateFeedViewController () <MSRequestUIDelegate, MSUploadImageDelegate>
@property (nonatomic, strong) MSAvarterCollectionViewController* avarterViewController;
@property (nonatomic, strong) UITextView* textView;
@property (nonatomic, strong) MSCreateFeedProcess* createProcessLogic;
@end

@implementation MSCreateFeedViewController
- (void) dealloc
{
}
- (void) ms_AddChildViewController:(UIViewController*)viewController
{
    [viewController willMoveToParentViewController:self];
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
}
- (void) initControls
{
    INIT_SUBVIEW(self.view, UITextView, _textView);
    _avarterViewController = [[MSAvarterCollectionViewController alloc] initWithAvarters:0 itemSize:CGSizeMake(100, 100)];
    _avarterViewController.canAddPhoto = YES;
    [self ms_AddChildViewController:_avarterViewController];
    
}




- (void) uploadImageManger:(MSUploadImageManager *)manager totalProcess:(float)process
{
   MRNavigationBarProgressView* progressView =  [MRNavigationBarProgressView progressViewForNavigationController:self.navigationController];
    [progressView setProgress:process animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initControls];
    [self loadLeftBarItemWithTitle:@"取消" action:@selector(dismissNavigationController)];
    [self loadRightBarItemWithTitle:@"发表" action:@selector(postFeed)];
    self.title = @"发表留言";
    // Do any additional setup after loading the view.
    _createProcessLogic = [MSCreateFeedProcess new];
    [[MSUILogicManager shareManager] addLogicProcess:_createProcessLogic];
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

- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    _textView.frame = CGRectMake(10, 10, CGRectGetViewControllerWidth - 20, 100);
    _avarterViewController.view.frame = CGRectMake(10, CGRectGetMaxY(_textView.frame) + 10, CGRectGetViewControllerWidth-20, 100);
}

- (void) postFeed
{
    NSError* error;
    
    if(![_createProcessLogic setContent:_textView.text error:&error])
    {
        [MSDefaultTipsPool showError:error];
        return;
    }
    _createProcessLogic.backgroundColor = @"#232323";
    _createProcessLogic.photoManager = _avarterViewController.photoManager;
    _createProcessLogic.contentReady = YES;
    [_createProcessLogic post];
    [self dismissNavigationController];
}

@end
