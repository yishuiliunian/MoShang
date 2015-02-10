//
//  MSLocationManager.m
//  MoShang
//
//  Created by stonedong on 15/2/9.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "MSLocationManager.h"
#import <DZSingletonFactory.h>
#import <UIKit/UIKit.h>
#import <INTULocationManager.h>
#import "MSLog.h"
#import <DZProgramDefines.h>
@implementation MSLocation
- (NSString*)serverEncodeString
{
    return [NSString stringWithFormat:@"%f;%f;%f;%@",self.longtitude, self.latitude, self.altitude, self.readDescription];
}
@end
@interface MSLocationManager () <CLLocationManagerDelegate>
{
    NSTimer* _requestLocationTimer;
}
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation MSLocationManager
+ (MSLocationManager*) shareManager
{
    return DZSingleForClass([self class]);
}


- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
    _currentLocation = [self loadStorageLocation];
    return self;
}

INIT_DZ_EXTERN_STRING(kMSLocationCurrentData, kMSLocationCurrentData1);

- (MSLocation*) loadStorageLocation
{
    NSString* dic = [[NSUserDefaults standardUserDefaults] objectForKey:kMSLocationCurrentData];
    MSLocation* locatin  = nil;
    if (dic) {
        NSError* error;
        locatin = [[MSLocation alloc] initWithString:dic error:&error];
        if (error) {
            DDLogError(@"%@",error);
        }
    } else {
        locatin = [MSLocation new];
    }
    return locatin;
}

- (void) storageCurrentLocation
{
    if (_currentLocation) {
        NSString* dic = [_currentLocation toJSONString];
        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:kMSLocationCurrentData];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


- (void) stopRequest
{
    [_requestLocationTimer invalidate];
    _requestLocationTimer = nil;
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation* location = manager.location;
    MSLocation* loc = [[MSLocation alloc] init];
    loc.longtitude = location.coordinate.longitude;
    loc.latitude = location.coordinate.latitude;
    loc.altitude = location.altitude;
    _currentLocation = loc;
    [self storageCurrentLocation];
}

@end
