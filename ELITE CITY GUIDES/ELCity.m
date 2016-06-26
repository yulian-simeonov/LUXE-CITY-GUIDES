//
//  ELCity.m
//  ELITE CITY GUIDES
//
//  Created by Tony Parker on 5/18/16.
//  Copyright © 2016 eliteLYFE. All rights reserved.
//

#import "ELCity.h"


@implementation ELCity

+ (ELCity *)cityWithDictionary:(NSDictionary *)cityDict
{
    if(!cityDict || ![cityDict isKindOfClass:[NSDictionary class]])
    {
        return nil;
    }
    
    return [[ELCity alloc] initWithDictionary:cityDict];
}

- (instancetype)initWithDictionary:(NSDictionary *)cityDict
{
    self = [super init];
    if(self)
    {
        [self configureWithDictionary:cityDict];
    }
    return self;
}

- (void)configureWithDictionary:(NSDictionary*)cityDict
{
    self.cityID             = cityDict[@"idCity"];
    self.cityName           = cityDict[@"cityName"];
    self.cityDescription    = cityDict[@"cityDescription"];
    self.cityImage          = cityDict[@"cityImage"];
    self.cityMapLocation    = cityDict[@"cityMapLocation"];
}

+ (NSDate*)dateFromString:(NSString*)dateString
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

@end
