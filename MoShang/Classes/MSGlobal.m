//
//  MSGlobal.m
//  MoShang
//
//  Created by stonedong on 15/1/28.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSGlobal.h"
#import <FCUUID.h>
#import <Haneke.h>
#import <UIImageView+Haneke.h>
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

NSArray* MSPicturesListFromStr(NSString* str) {
    NSArray* ps = [str componentsSeparatedByString:@";"];
    NSMutableArray* pictures = [NSMutableArray new];
    for (NSString* p  in ps) {
        if ([p isEqualToString:@""]) {
            continue;
        }
        [pictures addObject:p];
    }
    return pictures;
}


void MSImageViewLoadContent(UIImageView* imageView, NSString* url, NSString* placeHolderName) {
    [imageView hnk_setImageFromURL:[NSURL URLWithString:url] placeholder:DZCachedImageByName(placeHolderName)];
}

void MSLoadHeadBoy(UIImageView* imageView, NSString* url) {
    MSImageViewLoadContent(imageView, url, @"default_avater_man");
}

void MSLoadHeadGirl(UIImageView* imageView, NSString* url) {
    MSImageViewLoadContent(imageView, url, @"default_avater_lady");
}

@implementation MSGlobal

@end
