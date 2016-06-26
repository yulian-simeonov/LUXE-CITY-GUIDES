//
//  ELCity.h
//  ELITE CITY GUIDES
//
//  Created by Yavor Krastev on 5/18/16.
//  Copyright © 2016 eliteLYFE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ELCity : NSObject

@property (nonatomic, strong) NSString *cityID;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *cityDescription;
@property (nonatomic, strong) NSString *cityImage;
@property (nonatomic, strong) NSString *cityMapLocation;

//@property (nonatomic, strong) UIImage *guideImage;

+ (ELCity *)cityWithDictionary:(NSDictionary *)cityDict;
- (void)configureWithDictionary:(NSDictionary *)cityDict;

+ (NSDate*) dateFromString:(NSString*) dateString;

@end
