//
//  MSGlobal.m
//  MoShang
//
//  Created by stonedong on 15/1/28.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSGlobal.h"
#import <FCUUID.h>
BOOL IS_MSColorString(NSString* str) {
    return [str hasPrefix:@"#"];
}

NSString* MSGenRandomUUID() {
    return [FCUUID uuid];
}


@implementation MSGlobal

@end
