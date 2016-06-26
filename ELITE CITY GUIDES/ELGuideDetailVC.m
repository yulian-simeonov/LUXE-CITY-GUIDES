//
//  ELGuideDetailVC.m
//  ELITE CITY GUIDES
//
//  Created by Tony Parker on 5/6/16.
//  Copyright © 2016 eliteLYFE. All rights reserved.
//

#import "ELGuideDetailVC.h"
#import "ELGuideDescriptionVC.h"
#import "ELGuideReviewVC.h"
#import "ELGuideWebsiteVC.h"
#import "ELGuideNearbyVC.h"
#import "ELGuideReportPopupVC.h"
#import "ELAppData.h"
#import "ParallaxHeaderView.h"


@interface ELGuideDetailVC ()

@property (strong, nonatomic) IBOutlet UIView *backNavigationView;
@property (strong, nonatomic) IBOutlet UIView *shareButtonView;

@property (strong, nonatomic) IBOutlet UIButton *guideBookButton;

@property (strong, nonatomic) IBOutlet UIButton *favoritesButton;
@property (strong, nonatomic) IBOutlet UIButton *itineraryButton;
@property (strong, nonatomic) IBOutlet UIButton *visitedButton;
@property (strong, nonatomic) IBOutlet UIButton *mapButton;
@property (strong, nonatomic) IBOutlet UIButton *directionsButton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *headerWidthConstraint;

@property (strong, nonatomic) IBOutlet UILabel *guideNameLabel;
@property (strong, nonatomic) IBOutlet UIView *guideRatingView;
@property (strong, nonatomic) IBOutlet UILabel *guideDescLabel;

@property (strong, nonatomic) IBOutlet UIButton *guideThoughtButton;

@property (strong, nonatomic) IBOutlet UITextView *addressLabel;
@property (strong, nonatomic) IBOutlet UIButton *callButton;
@property (strong, nonatomic) IBOutlet UIButton *websiteButton;

@property (strong, nonatomic) IBOutlet UIButton *reportChangeButton;

@property (nonatomic) NSInteger selectedIndex;

@property (strong, nonatomic) NSString *goToURL;

@end


@implementation ELGuideDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backNavigationView.layer.cornerRadius = self.backNavigationView.frame.size.width / 2.;
    [self.backNavigationView.layer setMasksToBounds:YES];
    self.backNavigationView.hidden = false;
    
    self.shareButtonView.layer.cornerRadius = self.shareButtonView.frame.size.width / 2.;
    [self.shareButtonView.layer setMasksToBounds:YES];
    self.shareButtonView.hidden = false;
    
    ParallaxHeaderView *headerView = [ParallaxHeaderView parallaxHeaderViewWithImage:self.placeGuide.placeImage forSize:CGSizeMake(self.tableView.frame.size.width, self.tableView.frame.size.width * 0.75)];
    [self.tableView setTableHeaderView:headerView];
    
    UIButton *extPhotoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, headerView.frame.size.height)];
    [extPhotoButton addTarget:self action:@selector(extendViewPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:extPhotoButton];
    
    self.guideBookButton.layer.cornerRadius = 3.0;
    
    CGFloat width = self.view.frame.size.width / 5;
    self.headerWidthConstraint.constant = width;
    
    self.guideThoughtButton.layer.cornerRadius = 3.0;
    
    self.callButton.layer.cornerRadius = 3.0;
    self.callButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.callButton.layer.borderWidth = 1.0;
    
    self.websiteButton.layer.cornerRadius = 3.0;
    self.websiteButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.websiteButton.layer.borderWidth = 1.0;
    
    self.reportChangeButton.layer.cornerRadius = 3.0;
    self.reportChangeButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.reportChangeButton.layer.borderWidth = 2.0;
}

//--------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
//    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
//    self.navigationController.navigationBar.translucent = NO;
}

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

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGFloat height = 50;
//    
//    if (indexPath.row == 0 && [self.placeGuide.placeGuideType isEqualToString:@"ShoppingGuide"]) {
//        height = 0;
//    }
//    
//    if (indexPath.row == 2) {
//        height = 142;
//    }
//    
//    if (indexPath.row == 4) {
//        height = 75;
//    }
//    
//    return height;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];

    if (indexPath.row == 2)
    {
        [self performSegueWithIdentifier:@"GoToDescription" sender:nil];
    }
    else if (indexPath.row == 5)
    {
        [self performSegueWithIdentifier:@"GoToNearby" sender:nil];
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
- (void)extendViewPhoto:(UIButton *)sender
{
    
}

//--------------------------------------------------------------------------------------------------------------
- (IBAction)guideBook:(id)sender
{
    [self performSegueWithIdentifier:@"GoToWebsite" sender:sender];
}

//--------------------------------------------------------------------------------------------------------------
- (IBAction)guideFavorites:(id)sender
{
    
}

- (IBAction)guideItinerary:(id)sender
{
    
}

- (IBAction)guideVisited:(id)sender
{
    
}

- (IBAction)guideMap:(id)sender
{
    
}

- (IBAction)guideDirections:(id)sender
{
    
}

//--------------------------------------------------------------------------------------------------------------
- (IBAction)guideReview:(id)sender
{
    
}

//--------------------------------------------------------------------------------------------------------------
- (IBAction)guidePhoneCall:(id)sender
{
    
}

- (IBAction)guideWebsite:(id)sender
{
    
}

//--------------------------------------------------------------------------------------------------------------
- (IBAction)guideReportChange:(UIButton *)sender
{
    
}

//--------------------------------------------------------------------------------------------------------------
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"GoToDescription"])
    {
        ELGuideDescriptionVC *vc = (ELGuideDescriptionVC *)segue.destinationViewController;
        [vc setGuideName:self.guideNameLabel.text];
        [vc setGuideDescription:self.guideDescLabel.text];
    }
    else if ([segue.identifier isEqualToString:@"GoToNearby"])
    {
        ELGuideNearbyVC *vc = (ELGuideNearbyVC *)segue.destinationViewController;
        [vc setPlace:self.placeGuide];
    }
}

@end
