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
@interface MSCreateFeedViewController () <MSRequestUIDelegate, MSUploadImageDelegate>
@property (nonatomic, strong) MSAvarterCollectionViewController* avarterViewController;
@property (nonatomic, strong) UITextView* textView;
@end

@implementation MSCreateFeedViewController
- (void) dealloc
{
    [_avarterViewController.uploadImageManager removeUploadImageObserver:self];
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
    
    [_avarterViewController.uploadImageManager addUploadImageObserver:self];
}

- (void) setPostEnable:(BOOL)enable
{
    self.navigationItem.rightBarButtonItem.enabled = enable;
}

- (void) uploadImageManger:(MSUploadImageManager *)manager uploadImage:(NSString *)key faild:(NSError *)error
{
    [self setPostEnable:!manager.isUploading];
}

- (void) uploadImageManger:(MSUploadImageManager *)manager uploadImageSucceed:(NSString *)key url:(NSString *)url
{
    [self setPostEnable:!manager.isUploading];
}

- (void) uploadImageManger:(MSUploadImageManager *)manager beginUploadImage:(NSString *)key
{
    [self setPostEnable:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initControls];
    [self loadLeftBarItemWithTitle:@"取消" action:@selector(dismissNavigationController)];
    [self loadRightBarItemWithTitle:@"发表" action:@selector(postFeed)];
    self.title = @"发表留言";
    // Do any additional setup after loading the view.
    
    [self setPostEnable:YES];
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
    NSArray* images = self.avarterViewController.avarters;
    for (NSString* a in images) {
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
