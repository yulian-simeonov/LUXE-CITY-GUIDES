//
//  ELPlaceGuide.m
//  ELITE CITY GUIDES
//
//  Created by Tony Parker on 5/20/16.
//  Copyright © 2016 eliteLYFE. All rights reserved.
//

#import "ELPlaceGuide.h"
#import <SDWebImage/SDWebImageManager.h>
#import "NSDate+DateTools.h"


@implementation ELPlaceGuide

+ (ELPlaceGuide *)place:(NSString *)placeType withDictionary:(NSDictionary *)placeDict
{
    if(!placeDict || ![placeDict isKindOfClass:[NSDictionary class]])
    {
        return nil;
    }
    
    return [[ELPlaceGuide alloc] init:placeType withDictionary:placeDict];
}

- (instancetype)init:(NSString *)placeType withDictionary:(NSDictionary *)placeDict
{
    self = [super init];
    if(self)
    {
        [self configure:placeType withDictionary:placeDict];
    }
    return self;
}

- (void)configure:(NSString *)placeType withDictionary:(NSDictionary*)placeDict
{
    self.placeGuideType     = placeType;

    if ([placeType isEqualToString:@"AccommodationGuide"])
    {
        self.placeID            = placeDict[@"idAccommodation"];
        self.placeName          = placeDict[@"accommodationName"];
        self.placeFreeType      = placeDict[@"accommodationType"];
        self.cityID             = placeDict[@"cityId"];
        self.placeDescription   = placeDict[@"accommodationDescription"];
        self.placePhoto         = placeDict[@"accommodationPhoto"];
        self.placeMapLocation   = placeDict[@"accommodationMapLocation"];
        self.placeAddress1      = placeDict[@"accommodationAddress1"];
        self.placeAddress2      = placeDict[@"accommodationAddress2"];
        self.placeCity          = placeDict[@"accommodationCity"];
        self.placeState         = placeDict[@"accommodationState"];
        self.placeCountry       = placeDict[@"accommodationCountry"];
        self.placePostal        = placeDict[@"accommodationPostal"];
        self.placePhone1        = placeDict[@"accommodationPhone1"];
        self.placePhone2        = placeDict[@"accommodationPhone2"];
        self.placeWebsite       = placeDict[@"accommodationWebsite"];
    }
    else if ([placeType isEqualToString:@"ActivityGuide"])
    {
    }
    else if ([placeType isEqualToString:@"BarClubGuide"])
    {
    }
    else if ([placeType isEqualToString:@"DiningGuide"])
    {
    }
    else if ([placeType isEqualToString:@"ShoppingGuide"])
    {
    }
    else if ([placeType isEqualToString:@"SpaBeautyGuide"])
    {
    }
    
    [self retrieveGuideImageWithCompletionHandler:^(NSError *error, UIImage *image, id result) {
        self.placeImage = image;
    } andKey:nil];
}

- (void)retrieveGuideImageWithCompletionHandler:(void (^)(NSError *, UIImage *, id))completionHandler andKey:(id)key
{
    if (!self.placeID || self.placeID == (id)[NSNull null] || !self.placePhoto || self.placePhoto == (id)[NSNull null])
    {
        if(completionHandler)
        {
            completionHandler(nil, [UIImage imageNamed:@"city_Image1"], key);
        }
        return;
    }
    
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:self.placePhoto]
                                                    options:(self.wantsNewImage ? SDWebImageRefreshCached :0)
                                                   progress:nil
                                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL)
     {
         if(error)
         {
             if(completionHandler)
             {
                 completionHandler(error, [UIImage imageNamed:@"city_Image1"], key);
             }
             return;
         }
         else
         {
             self.placeImage = image;
             self.wantsNewImage = NO;
             
             if(completionHandler) {
                 completionHandler(nil, image, key);
             }
         }
     }];
}

+ (NSDate *)dateFromString:(NSString *)dateString
{
    static NSDateFormatter* formatter = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate ,^ {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
        
    });
    return [formatter dateFromString:dateString];
}

- (BOOL)isEqual:(id)object
{
    if (self == object)
    {
        return YES;
    }
    
    if (![object isKindOfClass:[ELPlaceGuide class]])
    {
        return NO;
    }
    
    ELPlaceGuide *other = object;
    return [self.placeID isEqualToString:other.placeID];
}

- (NSUInteger)hash
{
    return [self.placeID hash];
}

@end
