//
//  DZCDNImageAction.m
//  TimeUI
//
//  Created by stonedong on 14-6-16.
//  Copyright (c) 2014年 Stone Dong. All rights reserved.
//

#import "DZCDNImageAction.h"
#import <UIKit/UIKit.h>
@implementation DZCDNImageAction

- (id) decodeCDNFileData:(NSData *)data error:(NSError *__autoreleasing *)error
{
    return [UIImage imageWithData:data];
}
@end
