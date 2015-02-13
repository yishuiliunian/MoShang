//
//  DZCDNJsonAction.m
//  TimeUI
//
//  Created by stonedong on 14-6-16.
//  Copyright (c) 2014年 Stone Dong. All rights reserved.
//

#import "DZCDNJsonAction.h"

@implementation DZCDNJsonAction
- (id) decodeCDNFileData:(NSData *)data error:(NSError **)error
{
    return  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:error];
}

@end
