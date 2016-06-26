//
//  ELAppData.h
//  ELITE CITY GUIDES
//
//  Created by Yavor Krastev on 5/20/16.
//  Copyright © 2016 eliteLYFE. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ELAppData : NSObject

@property (strong, nonatomic) NSMutableArray *cityList;

@property (strong, nonatomic) NSString *cityID;
@property (strong, nonatomic) NSString *cityName;

@property (strong, nonatomic) NSMutableArray *accommodationArray;
@property (strong, nonatomic) NSMutableArray *activitiesArray;
@property (strong, nonatomic) NSMutableArray *barsClubsArray;
@property (strong, nonatomic) NSMutableArray *diningArray;
@property (strong, nonatomic) NSMutableArray *shoppingArray;
@property (strong, nonatomic) NSMutableArray *spaBeautyArray;

+ (ELAppData *)appData;

- (void)clearListCache;
- (void)clearGuideCache;

@end
