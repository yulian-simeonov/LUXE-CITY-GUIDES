//
//  ELAPI.m
//  ELITE CITY GUIDES
//
//  Created by Yavor Krastev on 5/18/16.
//  Copyright © 2016 eliteLYFE. All rights reserved.
//

#import "ELAPI.h"
#import "ELCity.h"
#import <AFNetworking/AFNetworking.h>
#import <Reachability.h>
#import <CommonCrypto/CommonHMAC.h>


NSString* const ELNetworkErrorStatusCodeKey = @"ELNetworkErrorStatusCodeKey";
NSString* const ELNetworkErrorDomain        = @"ELNetworkErrorDomain";
NSString* const ELNetworkErrorMessageKey    = @"ELNetworkErrorMessageKey";

#define BASE_URL            @"https://www.elitelyfe.com/apps/cityguide/fetch.php"

#define CITIES              @"cities"
#define ACCOMMODATIONS      @"accommodations"
#define ACTIVITIES          @"activities"
#define BARSCLUBS           @"barsclubs"
#define DINING              @"dining"
#define SHOPPING            @"shopping"
#define SPABEAUTY           @"spabeauty"


@implementation ELAPI

+ (NSURL *)serverURLWithPath:(NSString*)path
{
    return [NSURL URLWithString:[BASE_URL stringByAppendingString:path]];
}

#pragma mark - Param Check

/**
 A function that check if any param is nil
 @param1 the first param
 @param2 the second number
 ...
 @returns bool value for check result
 */
+ (BOOL)checkStringParamsNil:(NSString*)param1, ... NS_REQUIRES_NIL_TERMINATION
{
    va_list args;
    va_start(args, param1);
    for (NSString *arg = param1; arg != nil; arg = va_arg(args, NSString*))
    {
        if (!arg || arg.length < 1)
        {
            return NO;
        }
    }
    va_end(args);
    
    return YES;
}

+ (BOOL)isConnectedInternet
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable) {            //No internet
        return NO;
    }
    else if (status == ReachableViaWiFi) {  //WiFi
        return YES;
    }
    else if (status == ReachableViaWWAN) {  //3G
        return YES;
    }
    
    return NO;
}

//SDImageCache *imageCache = [SDImageCache sharedImageCache];
//[imageCache clearMemory];
//[imageCache clearDisk];

//--------------------------------------------------------------------------------------------------------------
+ (void)getCitiesWithCompletionHandler:(void(^)(BOOL error, id result))completionHandler
{
    if (![self isConnectedInternet])
    {
        completionHandler(YES, @"No internet connection! Please check your wifi or cell signal and try again.");
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@?transform=1", BASE_URL, CITIES];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        if (responseObject) {
            completionHandler(NO, responseObject);
        }
        else{
            completionHandler(YES, nil);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        //NSLog(@"Error: %@", error);
        completionHandler(YES, error.description);
    }];
}

//--------------------------------------------------------------------------------------------------------------
+ (void)getCityGuide:(NSString *)cityName withCompletionHandler:(void(^)(BOOL error, id result))completionHandler
{
    if (![self isConnectedInternet])
    {
        completionHandler(YES, @"No internet connection! Please check your wifi or cell signal and try again.");
        return;
    }
    
    if (![self checkStringParamsNil:cityName, nil])
    {
        completionHandler(YES, @"Empty City Name! Please check city name again.");
        return;
    }
    
//    NSString *url = [NSString stringWithFormat:@"%@/%@?transform=1", BASE_URL, CITIES];
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//    
//    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//        if (responseObject) {
//            completionHandler(NO, responseObject);
//        }
//        else{
//            completionHandler(YES, nil);
//        }
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//        completionHandler(YES, error.description);
//    }];
}

//--------------------------------------------------------------------------------------------------------------
+ (void)getAccomodationsFromCity:(NSString *)cityID
                            type:(NSString *)accommodationType
           withCompletionHandler:(void(^)(BOOL error, id result))completionHandler
{
    if (![self isConnectedInternet])
    {
        completionHandler(YES, @"No internet connection! Please check your wifi or cell signal and try again.");
        return;
    }
    
    if (![self checkStringParamsNil:cityID, nil])
    {
        completionHandler(YES, @"Empty City ID! Please check city ID again.");
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@?transform=1", BASE_URL, ACCOMMODATIONS];
    url = [url stringByAppendingString:[NSString stringWithFormat:@"&filter=accommodationType,eq,%@", accommodationType]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        if (responseObject) {
            completionHandler(NO, responseObject);
        }
        else{
            completionHandler(YES, nil);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        //NSLog(@"Error: %@", error);
        completionHandler(YES, error.description);
    }];
}

//--------------------------------------------------------------------------------------------------------------
+ (void)getActivitiesFromCity:(NSString *)cityID
                         type:(NSString *)activitiesType
        withCompletionHandler:(void (^)(BOOL, id))completionHandler
{
    if (![self isConnectedInternet])
    {
        completionHandler(YES, @"No internet connection! Please check your wifi or cell signal and try again.");
        return;
    }
    
    if (![self checkStringParamsNil:cityID, nil])
    {
        completionHandler(YES, @"Empty City ID! Please check city ID again.");
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@?transform=1", BASE_URL, ACTIVITIES];
    url = [url stringByAppendingString:[NSString stringWithFormat:@"&filter=activitiesType,eq,%@", activitiesType]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        if (responseObject) {
            completionHandler(NO, responseObject);
        }
        else{
            completionHandler(YES, nil);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        //NSLog(@"Error: %@", error);
        completionHandler(YES, error.description);
    }];
}

//--------------------------------------------------------------------------------------------------------------
+ (void)getBarsClubsFromCity:(NSString *)cityID
                        type:(NSString *)barsclubsType
       withCompletionHandler:(void (^)(BOOL, id))completionHandler
{
    if (![self isConnectedInternet])
    {
        completionHandler(YES, @"No internet connection! Please check your wifi or cell signal and try again.");
        return;
    }
    
    if (![self checkStringParamsNil:cityID, nil])
    {
        completionHandler(YES, @"Empty City ID! Please check city ID again.");
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@?transform=1", BASE_URL, BARSCLUBS];
    url = [url stringByAppendingString:[NSString stringWithFormat:@"&filter=barsclubsType,eq,%@", barsclubsType]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        if (responseObject) {
            completionHandler(NO, responseObject);
        }
        else{
            completionHandler(YES, nil);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        //SLog(@"Error: %@", error);
        completionHandler(YES, error.description);
    }];
}

//--------------------------------------------------------------------------------------------------------------
+ (void)getDiningFromCity:(NSString *)cityID
                     type:(NSString *)diningType
    withCompletionHandler:(void (^)(BOOL, id))completionHandler
{
    if (![self isConnectedInternet])
    {
        completionHandler(YES, @"No internet connection! Please check your wifi or cell signal and try again.");
        return;
    }
    
    if (![self checkStringParamsNil:cityID, nil])
    {
        completionHandler(YES, @"Empty City ID! Please check city ID again.");
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@?transform=1", BASE_URL, DINING];
    url = [url stringByAppendingString:[NSString stringWithFormat:@"&filter=diningType,eq,%@", diningType]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        if (responseObject) {
            completionHandler(NO, responseObject);
        }
        else{
            completionHandler(YES, nil);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        //NSLog(@"Error: %@", error);
        completionHandler(YES, error.description);
    }];
}

//--------------------------------------------------------------------------------------------------------------
+ (void)getShoppingFromCity:(NSString *)cityID
                       type:(NSString *)shoppingType
      withCompletionHandler:(void (^)(BOOL, id))completionHandler
{
    if (![self isConnectedInternet])
    {
        completionHandler(YES, @"No internet connection! Please check your wifi or cell signal and try again.");
        return;
    }
    
    if (![self checkStringParamsNil:cityID, nil])
    {
        completionHandler(YES, @"Empty City ID! Please check city ID again.");
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@?transform=1", BASE_URL, SHOPPING];
    url = [url stringByAppendingString:[NSString stringWithFormat:@"&filter=shoppingType,eq,%@", shoppingType]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        if (responseObject) {
            completionHandler(NO, responseObject);
        }
        else{
            completionHandler(YES, nil);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        //NSLog(@"Error: %@", error);
        completionHandler(YES, error.description);
    }];
}

//--------------------------------------------------------------------------------------------------------------
+ (void)getSpaBeautyFromCity:(NSString *)cityID
                        type:(NSString *)spabeautyType
       withCompletionHandler:(void (^)(BOOL, id))completionHandler
{
    if (![self isConnectedInternet])
    {
        completionHandler(YES, @"No internet connection! Please check your wifi or cell signal and try again.");
        return;
    }
    
    if (![self checkStringParamsNil:cityID, nil])
    {
        completionHandler(YES, @"Empty City ID! Please check city ID again.");
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@?transform=1", BASE_URL, SPABEAUTY];
    url = [url stringByAppendingString:[NSString stringWithFormat:@"&filter=spabeautyType,eq,%@", SPABEAUTY]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        if (responseObject) {
            completionHandler(NO, responseObject);
        }
        else{
            completionHandler(YES, nil);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        //NSLog(@"Error: %@", error);
        completionHandler(YES, error.description);
    }];
}

//--------------------------------------------------------------------------------------------------------------
+ (NSString*)routeString:(NSString*)route withParams:(NSDictionary*)params
{
    NSMutableString* routeMutable = [route mutableCopy];
    [routeMutable appendString:@"?"];
    BOOL first = true;
    for(NSString* param in params)
    {
        if(!first)
        {
            [routeMutable appendString:@"&"];
        }
        [routeMutable appendString:param];
        [routeMutable appendString:@"="];
        [routeMutable appendString:[[params objectForKey:param] description]];
        first = false;
    }
    return routeMutable;
}

//--------------------------------------------------------------------------------------------------------------
+ (void)getRoute:(NSString *)route withDataHandler:(void (^)(NSError *, NSData *))dataHandler withMethod:(NSString*)method forceRefresh:(BOOL)refresh
{
    NSURL* serverURL = [ELAPI serverURLWithPath:route];
    NSLog(@"Biite URL: %@",serverURL);
    
    NSURLSession* session = [NSURLSession sharedSession];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:serverURL];
    if(refresh)
    {
        request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    }
    request.HTTPMethod = method;
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:[ELAPI processNSDataWithCompletionHandler:dataHandler]];
    [task resume];
}

+ (void)getRoute:(NSString *)route withDataHandler:(void (^)(NSError *, NSData *))dataHandler withMethod:(NSString*)method
{
    [self getRoute:route withDataHandler:dataHandler withMethod:method forceRefresh:NO];
}

+ (void)getRoute:(NSString *)route withDataHandler:(void (^)(NSError *, NSData *))dataHandler
{
    [self getRoute:route withDataHandler:dataHandler withMethod:@"GET"];
}

+ (void)getRoute:(NSString *)route withDataHandler:(void (^)(NSError *, NSData *))dataHandler forceRefresh:(BOOL)refresh
{
    [self getRoute:route withDataHandler:dataHandler withMethod:@"GET" forceRefresh:refresh];
}

+ (void)getRoute:(NSString*)route withJSONResultHandler:(void (^)(NSError* error, id result))resultHandler
{
    [ELAPI getRoute:route withDataHandler:[ELAPI processJSONWithCompletionHandler:resultHandler]];
}

+ (void)getRoute:(NSString*)route withJSONResultHandler:(void (^)(NSError* error, id result))resultHandler forceRefresh:(BOOL)refresh
{
    [ELAPI getRoute:route withDataHandler:[ELAPI processJSONWithCompletionHandler:resultHandler] forceRefresh:refresh];
}

+ (void)getRoute:(NSString*)route withJSONResultHandler:(void (^)(NSError* error, id result))resultHandler withMethod:(NSString*)method
{
    [ELAPI getRoute:route withDataHandler:[ELAPI processJSONWithCompletionHandler:resultHandler] withMethod:method];
}

+ (void)getRoute:(NSString*)route withJSONResultHandler:(void (^)(NSError* error, id result))resultHandler withMethod:(NSString*)method forceRefresh:(BOOL)refresh
{
    [ELAPI getRoute:route withDataHandler:[ELAPI processJSONWithCompletionHandler:resultHandler] withMethod:method forceRefresh:refresh];
}

+ (void)getRoute:(NSString*)route withParams:(NSDictionary*)params withDataHandler:(void (^)(NSError* error, NSData* data))dataHandler withMethod:(NSString*)method
{
    NSString* newRouteString = [ELAPI routeString:route withParams:params];
    [ELAPI getRoute:newRouteString withDataHandler:dataHandler withMethod:method];
}

+ (void)getRoute:(NSString*)route withParams:(NSDictionary*)params withDataHandler:(void (^)(NSError* error, NSData* data))dataHandler withMethod:(NSString*)method forceRefresh:(BOOL)refresh
{
    NSString* newRouteString = [ELAPI routeString:route withParams:params];
    [ELAPI getRoute:newRouteString withDataHandler:dataHandler withMethod:method forceRefresh:refresh];
}

+ (void)getRoute:(NSString*)route withParams:(NSDictionary*)params withDataHandler:(void (^)(NSError* error, NSData* data))dataHandler
{
    NSString* newRouteString = [ELAPI routeString:route withParams:params];
    [ELAPI getRoute:newRouteString withDataHandler:dataHandler];
}

+ (void)getRoute:(NSString*)route withParams:(NSDictionary*)params withDataHandler:(void (^)(NSError* error, NSData* data))dataHandler forceRefresh:(BOOL)refresh
{
    NSString* newRouteString = [ELAPI routeString:route withParams:params];
    [ELAPI getRoute:newRouteString withDataHandler:dataHandler forceRefresh:refresh];
}

+ (void)getRoute:(NSString*)route withParams:(NSDictionary*)params withJSONResultHandler:(void (^)(NSError* error, id result))resultHandler
{
    NSString* newRouteString = [ELAPI routeString:route withParams:params];
    [ELAPI getRoute:newRouteString withJSONResultHandler:resultHandler];
}

+ (void)getRoute:(NSString*)route withParams:(NSDictionary*)params withJSONResultHandler:(void (^)(NSError* error, id result))resultHandler forceRefresh:(BOOL)refresh
{
    NSString* newRouteString = [ELAPI routeString:route withParams:params];
    [ELAPI getRoute:newRouteString withJSONResultHandler:resultHandler forceRefresh:refresh];
}

+ (void)getRoute:(NSString*)route withParams:(NSDictionary*)params withJSONResultHandler:(void (^)(NSError* error, id result))resultHandler withMethod:(NSString*)method
{
    NSString* newRouteString = [ELAPI routeString:route withParams:params];
    [ELAPI getRoute:newRouteString withJSONResultHandler:resultHandler withMethod:method];
}

+ (void)getRoute:(NSString*)route withParams:(NSDictionary*)params withJSONResultHandler:(void (^)(NSError* error, id result))resultHandler withMethod:(NSString*)method forceRefresh:(BOOL)refresh
{
    NSString* newRouteString = [ELAPI routeString:route withParams:params];
    [ELAPI getRoute:newRouteString withJSONResultHandler:resultHandler withMethod:method forceRefresh:refresh];
}

//--------------------------------------------------------------------------------------------------------------
+ (void)postToRoute:(NSString*)route withData:(NSData*)data withCompletionHandler:(void (^)(NSError* error, NSData* data))completionHandler
{
    NSURL* serverURL = [ELAPI serverURLWithPath:route];
    NSLog(@"request: %@",serverURL);
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:serverURL];
    request.HTTPMethod = @"POST";
    request.HTTPBody = data;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:[ELAPI processNSDataWithCompletionHandler:completionHandler]];
    [task resume];
}

+ (void)postToRoute:(NSString*)route withParams:(NSDictionary*)params withData:(NSData*)data withCompletionHandler:(void (^)(NSError* error, NSData* data))completionHandler
{
    NSString* newRouteString = [ELAPI routeString:route withParams:params];
    [ELAPI postToRoute:newRouteString withData:data withCompletionHandler:completionHandler];
}

+ (void)postToRoute:(NSString *)route withParams:(NSDictionary*)params withJSONObject:(id)json withCompletionHandler:(void (^)(NSError *, id))completionHandler
{
    if(!json)
    {
        [ELAPI postToRoute:route withParams:params withData:nil withCompletionHandler:[ELAPI processJSONWithCompletionHandler:completionHandler]];
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSError* JSONError = nil;
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:json options:0 error:&JSONError];
        
        if(JSONError)
        {
            if(completionHandler)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completionHandler(JSONError, nil);
                });
            }
        }
        else
        {
            NSURL* serverURL = [ELAPI serverURLWithPath:route];
            
            NSLog(@"request: %@",serverURL);
            
            NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:serverURL];
            request.HTTPMethod = @"POST";
            request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
            request.HTTPBody = jsonData;
            NSURLSession* session = [NSURLSession sharedSession];
            NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:[ELAPI processNSDataWithCompletionHandler:[ELAPI processJSONWithCompletionHandler:completionHandler]]];
            [task resume];
        }
    });
}

+ (void (^)(NSError *error, NSData *data))processJSONWithCompletionHandler:(void (^)(NSError *, id))completionHandler
{
    return ^(NSError *error, NSData *data)
    {
        if(!data)
        {
            if(completionHandler)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completionHandler(error, nil);
                });
            }
            return;
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSError* JSONError = nil;
            id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONError];
            
            //Json output here
            if(!error && JSONError)
            {
                if(completionHandler)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completionHandler(JSONError, result);
                    });
                }
            }
            else
            {
                if(completionHandler)
                {
                    NSError* parsedError = nil;
                    if(error)
                    {
                        NSMutableDictionary* userDict = [error.userInfo mutableCopy];
                        NSUInteger statusCode = 0;
                        if(result[@"statusCode"])
                        {
                            statusCode = [result[@"statusCode"] unsignedIntegerValue];
                            if(statusCode != ELNETWORK_SUCCESS_CODE)
                            {
                                statusCode+=1000;
                            }
                        }
                        if(!statusCode)
                        {
                            statusCode = error.code;
                        }
                        
                        if(result[@"result"][@"error"])
                        {
                            userDict[ELNetworkErrorMessageKey] = result[@"result"][@"error"];
                        }
                        
                        userDict[ELNetworkErrorStatusCodeKey] = [NSNumber numberWithUnsignedInteger:statusCode];
                        parsedError = [NSError errorWithDomain:ELNetworkErrorDomain code:statusCode userInfo:userDict];
                    }
                    else
                    {
                        parsedError = error;
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"GET MAIN QUEUE");
                        completionHandler(parsedError, result);
                    });
                }
            }
        });
    };
}

+ (void)customQueryMYSQLsql:(NSString*)sql completionHandler:(void (^)(NSError *error, NSArray *jsonArray))completionHandler
{
    NSString *post = [NSString stringWithFormat:@"sql=%@",sql];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://www.pixelandprocessor.com/venturecity/query.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error)
                                      {
                                          if (!error)
                                          {
                                              NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:location] options:NSJSONReadingAllowFragments error:&error];
                                              
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  completionHandler(nil,jsonArray);
                                              });
                                          }
                                          else
                                          {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  completionHandler(error,nil);
                                              });
                                          }
                                      }];
    [task resume];
}

+ (void (^)(NSData *data, NSURLResponse *response, NSError *error))processNSDataWithCompletionHandler:(void (^)(NSError *, id))completionHandler
{
    return ^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if(error)
        {
            if(completionHandler)
            {
                completionHandler(error, data);
            }
            return;
        }
        NSInteger statusCode = [(NSHTTPURLResponse*)response statusCode];
        if(statusCode != 200)
        {
            NSError* error = [NSError errorWithDomain:ELNetworkErrorDomain code:statusCode userInfo:@{ELNetworkErrorStatusCodeKey: [NSNumber numberWithInteger:statusCode]}];
            if(completionHandler)
            {
                completionHandler(error, data);
            }
            return;
        }
        if(completionHandler)
        {
            completionHandler(nil, data);
        }
    };
}

@end
