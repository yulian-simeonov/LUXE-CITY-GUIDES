//
//  ELCityExploreTableCell.m
//  ELITE CITY GUIDES
//
//  Created by Yavor Krastev on 5/6/16.
//  Copyright © 2016 eliteLYFE. All rights reserved.
//

#import "ELCityExploreTableCell.h"

#define kArrowSizeRatio .12
#define kStopSizeRatio  .3
#define kTickWidthRatio .3


@implementation ELCityExploreTableCell

- (void)awakeFromNib {
    // Initialization code
    
    self.loadingProgressView.animationImages = [NSArray arrayWithObjects:
                                                [UIImage imageNamed:@"loading_icon1_1"],
                                                [UIImage imageNamed:@"loading_icon1_2"],
                                                [UIImage imageNamed:@"loading_icon1_3"],
                                                [UIImage imageNamed:@"loading_icon1_4"],
                                                [UIImage imageNamed:@"loading_icon1_5"],
                                                [UIImage imageNamed:@"loading_icon1_6"],
                                                [UIImage imageNamed:@"loading_icon1_7"],
                                                [UIImage imageNamed:@"loading_icon1_8"],
                                                [UIImage imageNamed:@"loading_icon1_9"],
                                                [UIImage imageNamed:@"loading_icon1_10"],
                                                [UIImage imageNamed:@"loading_icon1_11"],
                                                [UIImage imageNamed:@"loading_icon1_12"],
                                                [UIImage imageNamed:@"loading_icon1_13"],
                                                [UIImage imageNamed:@"loading_icon1_14"],
                                                [UIImage imageNamed:@"loading_icon1_15"],
                                                [UIImage imageNamed:@"loading_icon1_16"],
                                                nil];
    
    self.loadingProgressView.animationDuration = 2;
    self.loadingProgressView.animationRepeatCount = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
