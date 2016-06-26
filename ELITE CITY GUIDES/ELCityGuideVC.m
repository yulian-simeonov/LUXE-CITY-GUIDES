//
//  ELCityGuideVC.m
//  ELITE CITY GUIDES
//
//  Created by Yavor Krastev on 5/6/16.
//  Copyright © 2016 eliteLYFE. All rights reserved.
//

#import "ELCityGuideVC.h"
#import "ELGuideListVC.h"
#import "ELGuideFavoritesVC.h"
#import "ELAppData.h"
#import "ParallaxHeaderView.h"
#import "UINavigationBar+Helper.h"


@interface ELCityGuideVC ()

@property (strong, nonatomic) NSDictionary *cityDict;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *headerWidthConstraint;

@property (strong, nonatomic) NSArray *guideType;

@property (nonatomic) NSInteger selectedIndex;

@end


@implementation ELCityGuideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city2" ofType:@"plist"];
    self.cityDict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
//    NSString *cityName = [[NSUserDefaults standardUserDefaults] objectForKey:@"CityName"];
    NSString *cityName = [ELAppData appData].cityName;
    
    ParallaxHeaderView *headerView = [ParallaxHeaderView parallaxHeaderViewWithImage:[UIImage imageNamed:[self.cityDict objectForKey:cityName]] forSize:CGSizeMake(self.tableView.frame.size.width, self.tableView.frame.size.width * 0.67)];
    [self.tableView setTableHeaderView:headerView];
    
    UILabel *cityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, headerView.frame.size.height - 25, headerView.frame.size.width - 16, 25)];
    cityNameLabel.textAlignment = NSTextAlignmentRight;
    [cityNameLabel setFont:[UIFont fontWithName:@"Inika" size:20]];
    [headerView addSubview:cityNameLabel];
    
    CGFloat width = self.view.frame.size.width / 4;
    self.headerWidthConstraint.constant = width;
    
    self.guideType = @[@"", @"Accommodation", @"Activities", @"BarsClubs", @"Dining", @"Shopping", @"SpaBeauty"];
}

//--------------------------------------------------------------------------------------------------------------
- (void)viewDidAppear:(BOOL)animated
{
//    [(ParallaxHeaderView *)self.tableView.tableHeaderView refreshBlurViewForNewImage];
    [super viewDidAppear:animated];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//--------------------------------------------------------------------------------------------------------------
#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndex = indexPath.row;

    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];

    if (indexPath.row == 7)
    {
        //NSLog(@"Premium Guide - selected");
//        self.guideType = @"PremiumGuide";
//        [self performSegueWithIdentifier:@"" sender:nil];
    }
    else if (indexPath.row == 8)
    {
        
    }
    else if (indexPath.row == 9)
    {
        
    }
    else {
        [self performSegueWithIdentifier:@"GoToGuideList" sender:nil];
    }
}

//--------------------------------------------------------------------------------------------------------------
#pragma mark UISCrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView)
    {
        // pass the current offset of the UITableView so that the ParallaxHeaderView layouts the subViews.
        [(ParallaxHeaderView *)self.tableView.tableHeaderView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
    }
}

//--------------------------------------------------------------------------------------------------------------
- (IBAction)onClickFavorites:(id)sender
{
    [self performSegueWithIdentifier:@"GoToFavorites" sender:sender];
}

- (IBAction)onClickSearch:(id)sender
{
    [self performSegueWithIdentifier:@"GoToSearch" sender:sender];
}

- (IBAction)onClickAroundMe:(id)sender
{
}

- (IBAction)onClickAR:(id)sender
{
}

//--------------------------------------------------------------------------------------------------------------
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"GoToGuideList"])
    {
        ELGuideListVC *vc = (ELGuideListVC *)segue.destinationViewController;
        [vc setGuideType:self.guideType[self.selectedIndex]];
    }
//    else if ([segue.identifier isEqualToString:@"GoToFavorites"])
//    {
//        ELGuideFavoritesVC *vc = (ELGuideFavoritesVC *)segue.destinationViewController;
//    }
}

@end
