//
//  MTFacebookUtils.h
//  Movett
//
//  Created by Jarrett Chen on 9/12/15.
//  Copyright (c) 2015 Movett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

extern NSString* const ELFacebookUserDidLoginNotification;
extern NSString* const ELFacebookUserDidLogoutNotification;
extern NSString* const ELFacebookUserDidCancelNotification;
extern NSString* const ELFacebookSessionErrorNotification;
extern NSString* const ELFacebookSessionErrorNotificationErrorMessageKey;
extern NSString* const ELFacebookAccessTokenKey;

@interface ELFacebookUtils : NSObject

+ (void)clearAccessToken;
+ (void)openSession;
+ (BOOL)isLoggedIn;
+ (NSDictionary *)accessTokenInfo;
+ (void)getMeInfoWithCompletionHandler:(void (^)(FBSDKGraphRequestConnection *connection, id result, NSError *fbError))completionHandler;

@end
