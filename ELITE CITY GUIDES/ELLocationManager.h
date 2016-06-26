//
//  ELLocationManager.h
//  ELITE CITY GUIDES
//
//  Created by Yavor Krastev on 5/19/16.
//  Copyright © 2016 eliteLYFE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ELLocationManager : NSObject

@property (nonatomic, strong, readonly) CLLocation* lastLocation;

+ (instancetype)sharedManager;

- (void)fetchLocationWithCompletionHandler:(void (^)(NSError* error, CLLocation* location))completionHandler;
- (void)getAuthorizationStatusWithSuccessHandler:(void (^)(CLAuthorizationStatus))success withFailHandler:(void (^)(CLAuthorizationStatus))fail;

@end
