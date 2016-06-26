//
//  MTFacebookUtils.m
//  Movett
//
//  Created by Jarrett Chen on 9/12/15.
//  Copyright (c) 2015 Movett. All rights reserved.
//

#import "ELFacebookUtils.h"


NSString* const ELFacebookUserDidLoginNotification = @"ELFacebookUserDidLoginNotification";
NSString* const ELFacebookUserDidLogoutNotification = @"ELFacebookUserDidLogoutNotification";
NSString* const ELFacebookSessionErrorNotification = @"ELFacebookSessionErrorNotification";
NSString* const ELFacebookUserDidCancelNotification = @"ELFacebookUserDidCancelNotification";
NSString* const ELFacebookSessionErrorNotificationErrorMessageKey = @"ELFacebookSessionErrorNotificationErrorMessageKey";
NSString* const ELFacebookAccessTokenKey = @"ELFacebookAccessTokenKey";


@implementation ELFacebookUtils

+ (NSArray*)initialReadPermissions
{
    return @[@"public_profile", @"email", @"user_friends"];
}

+ (void)clearAccessToken
{
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
}

+ (void)openSession
{
    NSLog(@"OPENSESSION");
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:[ELFacebookUtils initialReadPermissions] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
    {
        if (error)
        {
            // Process error
            NSLog(@"error %@",error);
            [[NSNotificationCenter defaultCenter] postNotificationName:ELFacebookSessionErrorNotification object:nil];
        }
        else if (result.isCancelled)
        {
            // Handle cancellations
            NSLog(@"error cancled");
        }
        else
        {
            NSLog(@"fab result: %@",result.token.tokenString);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:ELFacebookUserDidLoginNotification object:nil];
        }
    }];
}

+ (BOOL)isLoggedIn
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        // User is logged in, do work such as go to next view controller.
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (NSDictionary *)accessTokenInfo
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        // User is logged in, do work such as go to next view controller.
        return @{@"access_token":[FBSDKAccessToken currentAccessToken].tokenString};
    }
    else
    {
        return nil;
    }

    //    if(FBSession.activeSession.isOpen) {
    //        DLog(@"access %@", [FBSettings sdkVersion]);
    //        return @{@"access_token":FBSession.activeSession.accessTokenData.accessToken};
    //    }
    //    return nil;
}

+ (void)getMeInfoWithCompletionHandler:(void (^)(FBSDKGraphRequestConnection *connection, id result, NSError *fbError))completionHandler
{
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                       parameters:@{@"fields":@"id,email,first_name,last_name,gender,link,picture.width(400).height(400)"}]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error)
    {
         dispatch_async(dispatch_get_main_queue(), ^{
             if(completionHandler)
             {
                 completionHandler(connection, result, error);
             }
         });
    }];
}

@end
