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

int64_t MSAlignTimeStamp(NSTimeInterval stamp) {
    return ceil(stamp * 1000);
}

int64_t MSCurrentTimeStamp()
{
    return MSAlignTimeStamp([[NSDate date] timeIntervalSince1970]);
}


NSString* MSCurrentTimeStapmStr()
{
    return [NSString stringWithFormat:@"%lld", MSCurrentTimeStamp()];
}


@implementation MSGlobal

@end
