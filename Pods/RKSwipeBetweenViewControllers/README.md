RKSwipeBetweenViewControllers
===========================

UIPageViewController and custom UISegmentedControl synchronized and animated.  Similar to Spotify's "My Music" section.

__Please check the .h to see how to customize anything__

##Pod
You may or may not want to use the pod depending on your preferred usage.  If you use the storyboard heavily, i would encourage you to not use the pod as you will probably have to use the class as your own custom class.  
	
	pod 'RKSwipeBetweenViewControllers'
	

## Demo: 
Don't worry about the colors, it's easy to change that to suit your own preferences.  I just kept colors to make it clear what's happening

![demo](http://i.imgur.com/zEsm542.gif)

Any number of any view controllers should technically work, though it doesn't look great with more than 4

__Customizeable!__

![Customizeable!](http://i.imgur.com/dl422EL.gif)

(check the RKSwipeBetweenViewControllers.h for *actual* customizeable features)

## how to use 
(check out the provided AppDelegate to see an example):

__Programmatically__ (preferred)

1. Import RKSwipeBetweenViewControllers.h
	
	```objc
	#import <RKSwipeBetweenViewControllers/RKSwipeBetweenViewControllers.h>
	```

2. Initialize a UIPageViewController
	
	```objc
	UIPageViewController *pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
	```
3. Initialize a RKSwipeBetweenViewControllers

  	```objc
	RKSwipeBetweenViewControllers *navigationController = [[RKSwipeBetweenViewControllers alloc]initWithRootViewController:pageController];
	```
4. Add all your ViewControllers (in order) to navigationController.viewControllerArray (try to keep it under 5)
  	
	```objc
	[navigationController.viewControllerArray addObjectsFromArray:@[viewController1, viewController2, viewController3]];
	```
5. Use the custom class (or call it as the first controller from app delegate: see below)
  	
	```objc
  	self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
  	self.window.rootViewController = navigationController;
  	[self.window makeKeyAndVisible];
  	```
  
__StoryBoard__
(do not use pods for this one)

1. Drop the file into your project and import RKSwipeBetweenViewControllers.h
	
	```objc
	#import RKSwipeBetweenViewControllers.h
	```

2. Embed a UIPageViewController inside a UINavigationController.  Change the class of the to UINavigationController the custom class (RKSwipeBetweenViewControllers)
3. change the transition style of the pageviewcontroller to scroll (click on the UIPageViewController in storyboard -> attributes inspector -> transition style -> scroll)

4. go to the RKSwipeBetweenViewControllers.m file and use it as your own class now.  Add your view controllers to "viewControllerArray".  See below for various options.

	*Programmatically, outside RKSwipeBetweenViewControllers.m*
	(if this navigation bar isn't the first screen that comes up, or if you want to call it from the delegate)
	
	```objc
	[customNavController.viewControllerArray addObjectsFromArray:@[viewController1, viewController2, viewController3]];
	```
	
	*Programmatically, inside RKSwipeBetweenViewControllers.m*
	(most cases if your view controllers are programmaticly created)
	
	```objc
	[viewControllerArray addObjectsFromArray:@[demo,demo2]];
	```
	*storyboard, inside RKSwipeBetweenViewControllers.m*
	(if your viewcontrollers are on the storyboard, but make sure to give them storyboard IDs)
	
	```objc
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	    UIViewController* theController = [storyboard instantiateViewControllerWithIdentifier:@"storyboardID"];
	
	    [viewControllerArray addObject:theController];
	```
	*storyboard, outside RKSwipeBetweenViewControllers.m*
	(if your viewcontrollers are on the storyboard, but make sure to give them storyboard IDs)
	
	```objc
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	    UIViewController* theController = [storyboard instantiateViewControllerWithIdentifier:@"storyboardID"];
	
	    [theCustomViewController.viewControllerArray addObject:theController];
	```



Any problems/questions? shoot me a pm


