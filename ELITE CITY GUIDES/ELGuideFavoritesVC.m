//
//  ELGuideFavoritesVC.m
//  ELITE CITY GUIDES
//
//  Created by Yavor Krastev on 5/22/16.
//  Copyright © 2016 eliteLYFE. All rights reserved.
//

#import "ELGuideFavoritesVC.h"
#import "ELGuideListTableCell.h"
#import "ELGuideDetailVC.h"
#import "ELGuidePopularityPopupVC.h"
#import "ELAppData.h"
#import "ELPlaceGuide.h"
#import <CoreLocation/CoreLocation.h>


@interface ELGuideFavoritesVC ()

@property (strong, nonatomic) IBOutlet UITableView *listTableView;
@property (strong, nonatomic) NSMutableArray *guideSets;

@property (nonatomic) NSInteger selectedIndex;

@property (strong, nonatomic) CLLocation *curLocation;

@property (strong, nonatomic) IBOutlet UILabel *placeGuideLabel;
@property (strong, nonatomic) IBOutlet UILabel *offlineGuildeLabel;
@property (strong, nonatomic) IBOutlet UILabel *addGuideLabel;
@property (strong, nonatomic) IBOutlet UIButton *upgradeButton;

@end


@implementation ELGuideFavoritesVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.guideSets = [[NSMutableArray alloc] init];
    [self getFavorites];
    
    CGFloat latCoord = [[[NSUserDefaults standardUserDefaults] objectForKey:@"curLatitude"] floatValue];
    CGFloat lonCoord = [[[NSUserDefaults standardUserDefaults] objectForKey:@"curLongitude"] floatValue];
    self.curLocation = [[CLLocation alloc] initWithLatitude:latCoord longitude:lonCoord];
    
    self.upgradeButton.layer.cornerRadius = 3.0;
}

//--------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//--------------------------------------------------------------------------------------------------------------
- (void)getFavorites
{
    
}

//--------------------------------------------------------------------------------------------------------------
- (IBAction)onClickSearch:(id)sender
{
}

- (IBAction)onClickPopularity:(id)sender
{
}

//--------------------------------------------------------------------------------------------------------------
- (IBAction)onClickUpgrade:(id)sender
{
}

//--------------------------------------------------------------------------------------------------------------
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.guideSets count];
}

- (ELGuideListTableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ELGuideListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ELGuideListTableCell" forIndexPath:indexPath];
    
    // Configure the cell...
    ELPlaceGuide *place = self.guideSets[indexPath.row];
    
    cell.guideImageView.image = place.placeImage;
    cell.guideNameLabel.text = place.placeName;
    
    NSString *coordStr = place.placeMapLocation;
    NSArray *coordArr = [coordStr componentsSeparatedByString: @","];
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[coordArr[0] floatValue] longitude:[coordArr[1] floatValue]];
    CLLocationDistance distance = [self.curLocation distanceFromLocation:location];
    CGFloat miles = distance / 1609.344;
    miles = miles < 1 ? 1 : miles;
    
    cell.guideAwayLabel.text = [NSString stringWithFormat:@"%.f miles", miles];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndex = indexPath.row;
    
    [self.listTableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [self performSegueWithIdentifier:@"GoToGuideDetail" sender:nil];
}

//--------------------------------------------------------------------------------------------------------------
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"GoToGuideDetail"])
    {
        ELGuideDetailVC *vc = (ELGuideDetailVC *)segue.destinationViewController;
        [vc setPlaceGuide:self.guideSets[self.selectedIndex]];
    }
}

@end
