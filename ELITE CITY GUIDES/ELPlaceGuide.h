//
//  ELPlaceGuide.h
//  ELITE CITY GUIDES
//
//  Created by Tony Parker on 5/20/16.
//  Copyright © 2016 eliteLYFE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ELPlaceGuide : NSObject

@property (nonatomic, strong) NSString *placeGuideType;
@property (nonatomic, strong) NSString *placeID;
@property (nonatomic, strong) NSString *placeName;
@property (nonatomic, strong) NSString *placeFreeType;
@property (nonatomic, strong) NSString *cityID;
@property (nonatomic, strong) NSString *placeDescription;
@property (nonatomic, strong) NSString *placePhoto;
@property (nonatomic, strong) NSString *placeMapLocation;
@property (nonatomic, strong) NSString *placeAddress1;
@property (nonatomic, strong) NSString *placeAddress2;
@property (nonatomic, strong) NSString *placeCity;
@property (nonatomic, strong) NSString *placeState;
@property (nonatomic, strong) NSString *placeCountry;
@property (nonatomic, strong) NSString *placePostal;
@property (nonatomic, strong) NSString *placePhone1;
@property (nonatomic, strong) NSString *placePhone2;
@property (nonatomic, strong) NSString *placeWebsite;

@property (nonatomic, strong) UIImage *placeImage;
@property (nonatomic) BOOL wantsNewImage;

+ (ELPlaceGuide *)place:(NSString *)placeType withDictionary:(NSDictionary *)placeDict;
- (void)configure:(NSString *)placeType withDictionary:(NSDictionary *)placeDict;

- (void)retrieveGuideImageWithCompletionHandler:(void (^)(NSError *, UIImage *, id))completionHandler andKey:(id)key;

+ (NSDate *)dateFromString:(NSString *)dateString;

@end
