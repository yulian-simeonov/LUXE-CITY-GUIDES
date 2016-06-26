//
//  ELGuideListTableCell.h
//  ELITE CITY GUIDES
//
//  Created by Yavor Krastev on 5/7/16.
//  Copyright © 2016 eliteLYFE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELGuideListTableCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *guideImageView;
@property (strong, nonatomic) IBOutlet UILabel *guideNameLabel;
@property (strong, nonatomic) IBOutlet UIView *guideRatingView;
@property (strong, nonatomic) IBOutlet UILabel *guideAwayLabel;

@end
