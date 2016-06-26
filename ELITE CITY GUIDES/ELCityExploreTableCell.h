//
//  ELCityExploreTableCell.h
//  ELITE CITY GUIDES
//
//  Created by Tony Parker on 5/6/16.
//  Copyright © 2016 eliteLYFE. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ELCityExploreTableCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *cityImageView;
@property (strong, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (strong, nonatomic) IBOutlet UIButton *cityDetailButton;
@property (strong, nonatomic) IBOutlet UIImageView *loadingProgressView;

@end
