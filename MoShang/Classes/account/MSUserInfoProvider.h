//
//  MSUserInfoProvider.h
//  MoShang
//
//  Created by stonedong on 15/3/15.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RCIM.h>
@interface MSUserInfoProvider : NSObject <RCIMUserInfoFetcherDelegagte>
+ (MSUserInfoProvider*) shareProvider;
- (void) cacheUserID:(NSString*)uid  nickName:(NSString*)nickName  avatar:(NSString*)url;
@end
