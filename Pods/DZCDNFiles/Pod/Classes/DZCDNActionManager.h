//
//  DZCDNActionManager.h
//  TimeUI
//
//  Created by stonedong on 14-6-16.
//  Copyright (c) 2014年 Stone Dong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^CDNImageDownloadedBlock)(UIImage*image, NSError*error);

@interface DZCDNActionManager : NSObject
+ (DZCDNActionManager*) shareManager;
- (void) downloadImage:(NSString*)url downloaded:(CDNImageDownloadedBlock)completion;
@end
