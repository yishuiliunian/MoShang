//
//  MSAlertPool.h
//  MoShang
//
//  Created by stonedong on 15/2/15.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#define MSDefaultAlertPool [MSAlertPool defaultPool]

#define MSAlertShowLoading(mssage) [MSDefaultAlertPool showLoadingWithMessage:mssage];
#define MSAlertHideLoading  [MSDefaultAlertPool hideAllAlert];
@interface MSAlertPool : NSObject
+ (MSAlertPool*) defaultPool;
- (void) showLoadingWithMessage:(NSString*)msg;
- (void) hideAllAlert;
@end
