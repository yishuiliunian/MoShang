//
//  MSLocationManager.h
//  MoShang
//
//  Created by stonedong on 15/2/9.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>

@interface MSLocation : JSONModel
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longtitude;
@property (nonatomic, assign) double altitude;
@property (nonatomic, strong) NSString<Optional>* readDescription;
@property (nonatomic, strong, readonly) NSString* serverEncodeString;
@end
@interface MSLocationManager : NSObject
@property (nonatomic, strong, readonly) MSLocation* currentLocation;
+ (MSLocationManager*) shareManager;
@end
