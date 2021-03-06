//
//  MSGlobalNavViewController.m
//  MoShang
//
//  Created by stonedong on 15/1/23.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSGlobalNavViewController.h"
#import "MSMainViewController.h"
#import "MSCreateFeedViewController.h"
#import "MSMessagesTableViewController.h"
#import "MSFeedsTableViewController.h"
#import "MSMineViewController.h"
#import "MSMasterTableViewController.h"
#import "MSTabBarItem.h"
#import <DZImageCache.h>
#import "MSGuideContentViewController.h"
#import "MSAccountManager.h"
#import <RCIM.h>
#import "MSPosFeedDataController.h"
#import <RCChatListViewController.h>

#import "MSChatListViewController.h"
#import <objc/runtime.h>
@interface MSGlobalNavViewController () <MSMainViewControllerDelegate, MSGuideContentDelegate>
@end

@implementation MSGlobalNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (MSShareAccountManager.currentAccount) {
        [MSShareAccountManager reloadRongCloudToken:NO];
        [self loadApplicationMainVC];
    } else
    {
        [self loadGuideVC];
    }
}

- (void) loadGuideVC
{
    MSGuideContentViewController* guideVC = [MSGuideContentViewController new];
    guideVC.guideContentDelegate = self;
    [self changMainViewController:guideVC];
}

- (void) loadApplicationMainVC
{
    
    typedef UIViewController* (^CreateViewController)();


#define CreateControllerFromClass(cls) ^{ \
    return (UIViewController*)[cls new]; \
}


    UINavigationController* (^CreateNavigationWithParams)(NSString* title,
                                                          CreateViewController createBlock,
                                                          NSString* imageName,
                                                          NSString* selectedImageName)
    = ^(NSString* title, CreateViewController createBlock, NSString* imageName, NSString* selectedImageName) {
        UIViewController* controller = createBlock() ;
        UINavigationController* navVC = [[UINavigationController alloc] initWithRootViewController: controller];
        MSTabBarItem* tabItem = [[MSTabBarItem alloc] initWithTitle:title image:DZCachedImageByName(imageName) selectedImage:DZCachedImageByName(selectedImageName)];
        navVC.tabBarItem = tabItem;
        controller.title = title;
        navVC.view.backgroundColor = [UIColor whiteColor];
        return navVC;
    };
    
    RCChatListViewController* chat =  [[RCIM sharedRCIM] createConversationList:
                                                        ^{
                                                            
                                                        }];
    object_setClass(chat, [MSChatListViewController class]);
    
    NSArray* viewControllers = @[CreateNavigationWithParams(@"留言",
                                                            ^{
                                                                MSFeedsTableViewController* feedVC = [MSFeedsTableViewController new];
                                                                feedVC.feedDataController = [MSPosFeedDataController new];
                                                                return feedVC;
                                                            },
                                                            
                                                            @"tab_nearby",
                                                            @"tab_nearby_click"),
                                 
                                 
                                 CreateNavigationWithParams(@"领主", CreateControllerFromClass(MSMasterTableViewController ), @"tab_hotnew", @"tab_hotnew_click"),
                                 
                                 
                                 
                                 CreateNavigationWithParams(@"消息",
                                                            ^ {return chat; },
                                                            @"tab_message",
                                                            @"tab_message_click"),
                                 
                                 CreateNavigationWithParams(@"我", CreateControllerFromClass(MSMineViewController ), @"tab_mine", @"tab_mine_click")];
    
    
    
    MSMainViewController* mainVC = [MSMainViewController new];
    mainVC.centerDelegate = self;
    [mainVC setViewControllers:viewControllers];
    
    [self changMainViewController:mainVC];
}
- (void) changMainViewController:(UIViewController*)vc
{
    [self ms_AddChildViewController:vc];
    _mainViewController = vc;
}

- (void) mainViewControllerDidTapCenterButton:(MSMainViewController *)mainVC
{
    UINavigationController* createNAV = [[UINavigationController alloc] initWithRootViewController:[MSCreateFeedViewController new]];
    [self presentViewController:createNAV animated:YES completion:^{
        
    }];
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

#pragma mark Guide Finished

- (void) guideContentViewController:(MSGuideContentViewController *)guideVC finished:(BOOL)finished
{
    
    [self loadApplicationMainVC];
}

@end
