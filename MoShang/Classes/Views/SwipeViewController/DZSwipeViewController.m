//
//  DZSwipeViewController.m
//  Pods
//
//  Created by stonedong on 15/3/5.
//
//

#import "DZSwipeViewController.h"
#import "DZTabViewItem.h"

CGFloat const kDZTabHeight = 44;
@interface DZSwipeViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate, DZTabViewDelegate, UIScrollViewDelegate>
{
    NSArray* _viewControllers;
    
    NSInteger _currentPageIndex;
    
    BOOL _tapTabbarAnimating;
}
@end
@implementation DZSwipeViewController
@synthesize pageViewController = _pageViewController;
@synthesize tabView = _tabView;

- (instancetype) initWithViewControllers:(NSArray*)viewControllers
{
    self = [super init];
    if (!self) {
        return self;
    }
    _viewControllers = viewControllers;
    return self;
}
- (void) dz_addChildViewController:(UIViewController*)vc
{
    [vc willMoveToParentViewController:self];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    [vc didMoveToParentViewController:self];
}
- (UIPageViewController*) pageViewController
{
    if (!_pageViewController) {
            _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        [self syncScrollView];

    }
    return _pageViewController;
}

- (DZTabView*) tabView
{
    if (!_tabView) {
        _tabView = [[DZTabView alloc] init];
        _tabView.delegate = self;
    }
    return _tabView;
}


- (void) viewDidLoad
{
    [super viewDidLoad];
    
    _tapTabbarAnimating = NO;
    [self dz_addChildViewController:self.pageViewController];
    [self.view addSubview:self.tabView];
    
    NSMutableArray* itemsArray = [NSMutableArray new];
    for (UIViewController* vc in _viewControllers) {
        DZTabViewItem* item = [DZTabViewItem new];
        item.textLabel.text = vc.swipeTitle;
        item.imageView.image = vc.swipeImage;
        [itemsArray addObject:item];
    }
    [self.tabView setItems:itemsArray];
    [self.pageViewController setViewControllers:@[_viewControllers[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

-(void)syncScrollView
{
    for (UIView* view in _pageViewController.view.subviews){
        if([view isKindOfClass:[UIScrollView class]])
        {
            UIScrollView* pageScrollView = (UIScrollView *)view;
            pageScrollView.delegate = self;
            
            [pageScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        }
    }
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
    }
}
- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _tabView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kDZTabHeight);
    _pageViewController.view.frame = CGRectMake(0, CGRectGetMaxY(_tabView.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - kDZTabHeight);
    
}


- (UIViewController*) pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [_viewControllers indexOfObject:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    if (index + 1 < _viewControllers.count) {
        return _viewControllers[index +1];
    }
    return nil;
}

- (UIViewController*) pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [_viewControllers indexOfObject:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    if (index > 0) {
        return _viewControllers[index -1];
    }
    return nil;
}
- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    UIViewController* vc = [self.pageViewController.viewControllers lastObject];
    
    CGRect rect =  [scrollView convertRect:vc.view.frame fromView:vc.view.superview];
    NSLog(@"xx  %f",rect.origin.x);
 
    if (!_tapTabbarAnimating) {
        CGFloat xFromCenter = self.view.frame.size.width-scrollView.contentOffset.x; //%%% positive for right swipe, negative for left
        
        
        CGFloat ratio =  xFromCenter / CGRectGetWidth(scrollView.frame);
       
        [self.tabView setSelectedViewOffSetRatio:ratio];
        
        NSLog(@"offset is %f", scrollView.contentOffset.x);
    }

}
- (void) dz_tabView:(DZTabView *)tabView didSelectedAtIndex:(NSUInteger)index
{
    
    UIPageViewControllerNavigationDirection direction =
    self.tabView.lastSelectedIndex > index ?
    UIPageViewControllerNavigationDirectionReverse :
    UIPageViewControllerNavigationDirectionForward;
    
    _tapTabbarAnimating = YES;
    [self.pageViewController setViewControllers:@[_viewControllers[index]] direction:direction animated:YES completion:^(BOOL finished) {
        _tapTabbarAnimating = NO;
    }];
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        _currentPageIndex = [_viewControllers indexOfObject:[self.pageViewController.viewControllers lastObject]];
        [self.tabView setSelectedIndex:_currentPageIndex];
    } else {
        
    }
}

- (void) pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    
}



@end
