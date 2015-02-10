//
//  MSAccountManager.h
//  MoShang
//
//  Created by stonedong on 15/2/7.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSAccount.h"

#define MSShareAccountManager  [MSAccountManager shareManager]
#define MSCurrentAccount [MSShareAccountManager currentAccount]
@interface MSAccountManager : NSObject
@property (nonatomic, strong, readonly) MSAccount* currentAccount;
+ (MSAccountManager*) shareManager;
- (void) reloadAccount:(MSAccount*)account;
@end
