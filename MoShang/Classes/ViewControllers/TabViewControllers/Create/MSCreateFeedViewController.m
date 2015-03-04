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
@interface MSCreateFeedViewController () <MSRequestUIDelegate>
@property (nonatomic, strong) MSAvarterCollectionViewController* avarterViewController;
@property (nonatomic, strong) UITextView* textView;
@end

@implementation MSCreateFeedViewController
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
    [self ms_AddChildViewController:_avarterViewController];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initControls];
    [self loadLeftBarItemWithTitle:@"取消" action:@selector(dismissNavigationController)];
    [self loadRightBarItemWithTitle:@"发表" action:@selector(postFeed)];
    self.title = @"发表留言";
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

- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    _textView.frame = CGRectMake(10, 10, CGRectGetViewControllerWidth - 20, 100);
    _avarterViewController.view.frame = CGRectMake(10, CGRectGetMaxY(_textView.frame) + 10, CGRectGetViewControllerWidth-20, 100);
}

- (void) postFeed
{
    NSString* picList = [NSString new];
    for (NSString* a in self.avarterViewController.avarters) {
       picList =  [picList stringByAppendingFormat:@"%@;", a];
    }
    MSPostFeedReq* postReq = [MSPostFeedReq new];
    postReq.content = _textView.text;
    postReq.piclist = picList;
    postReq.backgroundColor = @"#333333";
    postReq.position = [MSLocationManager shareManager].currentLocation.serverEncodeString;
    postReq.uidelegate = self;
    [MSDefaultSyncCenter performRequest:postReq];
    
    MSAlertShowLoading(@"发表中....")
}

- (void) request:(MSRequest *)request onError:(NSError *)error
{
    MSAlertHideLoading
    [MSDefaultTipsPool showError:error];
}

- (void) request:(MSRequest *)request onSucced:(id)object
{
    MSAlertHideLoading
    [self dismissNavigationController];
}
@end
