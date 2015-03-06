//
//  MSGlobal.h
//  MoShang
//
//  Created by stonedong on 15/1/28.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+Read.h"
#import "NSError+MS.h"
#import "UIViewController+Custom.h"
#import "MSAlertPool.h"
#import "MSTipsPool.h"


#define NUM_TO_STRING(x) [@(x) stringValue]
FOUNDATION_EXTERN BOOL IS_MSColorString(NSString* str);

#define MSGenerateRandomUUID MSGenRandomUUID()
FOUNDATION_EXTERN NSString* MSGenRandomUUID();

FOUNDATION_EXTERN NSString* MSCurrentTimeStapmStr();
@interface MSGlobal : NSObject

@end
