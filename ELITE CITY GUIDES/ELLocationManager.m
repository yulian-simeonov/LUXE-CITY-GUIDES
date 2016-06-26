//
//  ELLocationManager.m
//  ELITE CITY GUIDES
//
//  Created by Yavor Krastev on 5/19/16.
//  Copyright © 2016 eliteLYFE. All rights reserved.
//

#import "ELLocationManager.h"

NSString* const BFLocationManagerDidUpdateNotification = @"BFLocationManagerDidUpdateNotification";
NSString* const BFLocationMonitoringDidFailNotification = @"BFLocationMonitoringDidFailNotification";
NSString* const BFLocationMonitoringErrorUserInfoKey = @"BFLocationMonitoringErrorUserInfoKey";


@interface ELLocationManager () <CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager* pointLocManager;

@property (nonatomic, strong) void (^locationCallback)(NSError *, CLLocation *);
@property (nonatomic, strong) void (^authFailCallback)(CLAuthorizationStatus);
@property (nonatomic, strong) void (^authSuccessCallback)(CLAuthorizationStatus);

@end


@implementation ELLocationManager

//-------------------------------------------------------------------------------------------------------------------------
+ (instancetype)sharedManager
{
    static ELLocationManager* manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ELLocationManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pointLocManager = [[CLLocationManager alloc] init];
            self.pointLocManager.delegate = self;
            self.pointLocManager.desiredAccuracy = kCLLocationAccuracyBest;
            self.pointLocManager.distanceFilter = kCLDistanceFilterNone;
        });
    }
    return self;
}

//-------------------------------------------------------------------------------------------------------------------------
- (void)getAuthorizationStatusWithSuccessHandler:(void (^)(CLAuthorizationStatus))success withFailHandler:(void (^)(CLAuthorizationStatus))fail
{
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)
    {
        if(success)
        {
            success([CLLocationManager authorizationStatus]);
        }
        [self.pointLocManager startUpdatingLocation];
    }
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
    {
        self.authFailCallback = fail;
        self.authSuccessCallback = success;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.pointLocManager requestAlwaysAuthorization];
        });
    }
    else
    {
        if(fail)
        {
            fail([CLLocationManager authorizationStatus]);
        }
    }
}

//-------------------------------------------------------------------------------------------------------------------------
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    _lastLocation = [locations lastObject];
    
    if(manager == self.pointLocManager)
    {
        if(self.locationCallback)
        {
            self.locationCallback(nil, self.lastLocation);
            self.locationCallback = nil;
        }
        
//        [self.pointLocManager stopUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if(manager == self.pointLocManager)
    {
        if(self.locationCallback)
        {
            self.locationCallback(error, nil);
            self.locationCallback = nil;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.pointLocManager stopUpdatingLocation];
        });
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if(status == kCLAuthorizationStatusAuthorizedAlways)
    {
        if(self.authSuccessCallback)
        {
            self.authSuccessCallback(status);
        }
        self.authSuccessCallback = nil;
        self.authFailCallback = nil;
    }
    else if(status != kCLAuthorizationStatusNotDetermined)
    {
        if(self.authFailCallback)
        {
            self.authFailCallback(status);
        }
        self.authSuccessCallback = nil;
        self.authFailCallback = nil;
    }
}

//-------------------------------------------------------------------------------------------------------------------------
- (void)fetchLocationWithCompletionHandler:(void (^)(NSError* error, CLLocation* location))completionHandler
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.locationCallback = completionHandler;
        
        [self.pointLocManager startUpdatingLocation];
    });
}

@end
