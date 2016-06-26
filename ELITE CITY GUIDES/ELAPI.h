//
//  ELAPI.h
//  ELITE CITY GUIDES
//
//  Created by Yavor Krastev on 5/18/16.
//  Copyright © 2016 eliteLYFE. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString* const ELNetworkErrorStatusCodeKey;
extern NSString* const ELNetworkErrorMessageKey;
extern NSString* const ELNetworkErrorDomain;
extern NSString* const kBackendVersion;

#define ELNETWORK_GENERIC_ERROR_CODE 1400
#define ELNETWORK_FORBIDDEN_ERROR_CODE 1403
#define ELNETWORK_ALREADY_ERROR_CODE 402
#define ELNETWORK_NOT_FOUND_ERROR_CODE 404
#define ELNETWORK_REJECT_ERROR_CODE 1401
#define NETWORK_NOT_AUTHORIZED_ERROR_CODE 401
#define ELNETWORK_VALIDATION_ERROR_CODE 1422
#define ELNETWORK_SERVER_ERROR_CODE 1500
#define ELNETWORK_SUCCESS_CODE 200
#define ELNETWORK_FACEBOOK_REJECT 500
#define NETWORK_NO_HOST -1004
#define NETWORK_NO_INTERNET -1009


@interface ELAPI : NSObject

+ (void)getCitiesWithCompletionHandler:(void(^)(BOOL error, id result))completionHandler;

+ (void)getCityGuide:(NSString *)cityName withCompletionHandler:(void(^)(BOOL error, id result))completionHandler;

+ (void)getAccomodationsFromCity:(NSString *)cityID
                            type:(NSString *)accommodationType
           withCompletionHandler:(void(^)(BOOL error, id result))completionHandler;

+ (void)getActivitiesFromCity:(NSString *)cityID
                         type:(NSString *)activitiesType
        withCompletionHandler:(void(^)(BOOL error, id result))completionHandler;

+ (void)getBarsClubsFromCity:(NSString *)cityID
                        type:(NSString *)barsclubsType
       withCompletionHandler:(void(^)(BOOL error, id result))completionHandler;

+ (void)getDiningFromCity:(NSString *)cityID
                     type:(NSString *)diningType
    withCompletionHandler:(void(^)(BOOL error, id result))completionHandler;

+ (void)getShoppingFromCity:(NSString *)cityID
                       type:(NSString *)shoppingType
      withCompletionHandler:(void(^)(BOOL error, id result))completionHandler;

+ (void)getSpaBeautyFromCity:(NSString *)cityID
                        type:(NSString *)spabeautyType
       withCompletionHandler:(void(^)(BOOL error, id result))completionHandler;

@end
