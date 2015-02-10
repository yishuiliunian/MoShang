//
//  MSRouter.h
//  MoShang
//
//  Created by stonedong on 15/2/4.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#define MSShareRouter [MSRouter shareRouter]
#define MSDefaultServerURL [MSShareRouter baseURL]

extern NSString* const HttpMethodPOST;
extern NSString* const HttpMethodGET;

@interface MSRouter : NSObject
@property (nonatomic, copy) NSString* baseURL;
+ (MSRouter*) shareRouter;
@end
