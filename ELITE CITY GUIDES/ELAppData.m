//
//  ELAppData.m
//  ELITE CITY GUIDES
//
//  Created by Yavor Krastev on 5/20/16.
//  Copyright © 2016 eliteLYFE. All rights reserved.
//

#import "ELAppData.h"

static ELAppData *instance = nil;


@implementation ELAppData

+ (ELAppData *)appData
{
    @synchronized(self)
    {
        if(instance == nil)
        {
            instance= [[ELAppData alloc] init];
        }
    }
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.cityList = [[NSMutableArray alloc] init];
        
        self.accommodationArray = [[NSMutableArray alloc] init];
        self.activitiesArray = [[NSMutableArray alloc] init];
        self.barsClubsArray = [[NSMutableArray alloc] init];
        self.diningArray = [[NSMutableArray alloc] init];
        self.shoppingArray = [[NSMutableArray alloc] init];
        self.spaBeautyArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)clearListCache
{
    [instance.cityList removeAllObjects];
}

- (void)clearGuideCache
{
    [instance.accommodationArray removeAllObjects];
    [instance.accommodationArray removeAllObjects];
    [instance.activitiesArray removeAllObjects];
    [instance.barsClubsArray removeAllObjects];
    [instance.diningArray removeAllObjects];
    [instance.shoppingArray removeAllObjects];
    [instance.spaBeautyArray removeAllObjects];
}

@end
