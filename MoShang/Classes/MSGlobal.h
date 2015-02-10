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


#define NUM_TO_STRING(x) [@(x) stringValue]

FOUNDATION_EXTERN BOOL IS_MSColorString(NSString* str);
@interface MSGlobal : NSObject

@end
