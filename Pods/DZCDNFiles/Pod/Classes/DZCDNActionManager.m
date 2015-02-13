//
//  DZCDNActionManager.m
//  TimeUI
//
//  Created by stonedong on 14-6-16.
//  Copyright (c) 2014年 Stone Dong. All rights reserved.
//

#import "DZCDNActionManager.h"
#import "DZSingletonFactory.h"
#import "DZCDNAction.h"
@interface NSOperationQueue (Image)
+ (NSOperationQueue*) CDNImageQueue;
@end


@implementation NSOperationQueue (Image)

+ (NSOperationQueue*) CDNImageQueue
{
    static NSOperationQueue* queue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = [NSOperationQueue new];
    });
    return queue;
}

@end

@implementation DZCDNActionManager

 + (DZCDNActionManager*) shareManager
{
    return DZSingleForClass([DZCDNActionManager class]);
}



- (void) downloadImage:(NSString*)url downloaded:(CDNImageDownloadedBlock)completion
{
    DZCDNAction* action = [DZCDNAction CDNActionForFileType:DZCDNFileTypeImage WithURL:[NSURL URLWithString:url] checkDuration:60*60*24*30 completion:^(id serverObject, NSError *error) {
        if (completion) {
            completion(serverObject, error);
        }
    }];
    [[NSOperationQueue CDNImageQueue] addOperation:action];
}

@end
