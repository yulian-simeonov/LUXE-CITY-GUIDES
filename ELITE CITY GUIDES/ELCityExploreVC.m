//
//  ELCityExploreVC.m
//  ELITE CITY GUIDES
//
//  Created by Yavor Krastev on 5/6/16.
//  Copyright © 2016 eliteLYFE. All rights reserved.
//

#import "ELCityExploreVC.h"
#import "ELCityExploreTableCell.h"
#import "ELLocationManager.h"
#import "ELCityGuidePopupVC.h"
#import "ELTabBarVC.h"
#import "ELAPI.h"
#import "ELAppData.h"
#import "ELCity.h"
#import "ELPlaceGuide.h"


@interface ELCityExploreVC () <PopupDelegate, UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate>
{
    PopupIncomingTransitionType incomingType;
    PopupOutgoingTransitionType outgoingType;
    
//    ELPopupView *popper;
}

@property (strong, nonatomic) NSArray *cityList;
@property (strong, nonatomic) IBOutlet UITableView *cityTableView;

@property (strong, nonatomic) NSDictionary *cityDict;

@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic) BOOL isLoadingProgress;

@end


@implementation ELCityExploreVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    [[ELLocationManager sharedManager] getAuthorizationStatusWithSuccessHandler:^(CLAuthorizationStatus status) {} withFailHandler:^(CLAuthorizationStatus status) {}];
    
    [[ELLocationManager sharedManager] fetchLocationWithCompletionHandler:^(NSError *error, CLLocation *location)
     {
         if (!error)
         {
             NSLog(@"location updated: %f, %f", location.coordinate.latitude, location.coordinate.longitude);
             
             [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%lu", (unsigned long)location.coordinate.latitude] forKey:@"curLatitude"];
             [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%lu", (unsigned long)location.coordinate.longitude] forKey:@"curLongitude"];
             [[NSUserDefaults standardUserDefaults] synchronize];
         }
         else
         {
             NSLog(@"location error: %@", error);
             [[NSUserDefaults standardUserDefaults] setObject:@"33.988744" forKey:@"curLatitude"];
             [[NSUserDefaults standardUserDefaults] setObject:@"-117.897399" forKey:@"curLongitude"];
         }
     }];
    
    self.cityList = [ELAppData appData].cityList;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city1" ofType:@"plist"];
    self.cityDict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    incomingType = PopupIncomingTransitionTypeEaseFromCenter;
    outgoingType = PopupOutgoingTransitionTypeEaseToCenter;
    
    self.isLoadingProgress = false;
}

//--------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    self.navigationItem.hidesBackButton = YES;
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//--------------------------------------------------------------------------------------------------------------
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cityList count];
}

- (ELCityExploreTableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ELCityExploreTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ELCityExploreTableCell" forIndexPath:indexPath];
    
    ELCity *city = [self.cityList objectAtIndex:indexPath.row];
    
    // Configure the cell...
    cell.cityImageView.image = [UIImage imageNamed:[self.cityDict objectForKey:city.cityName]];
    cell.cityNameLabel.text = city.cityName;
    
    cell.cityDetailButton.tag = indexPath.row * 10 + 1;
    [cell.cityDetailButton addTarget:self action:@selector(showDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.loadingProgressView.hidden = true;
    cell.loadingProgressView.tag = indexPath.row * 10 + 2;
    
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:lineView];
    
    UILabel *labelHeader = [[UILabel alloc] initWithFrame:CGRectMake(8, 5, tableView.bounds.size.width - 16, 20)];
    [labelHeader setFont:[UIFont systemFontOfSize:16]];
    [labelHeader setTextColor:[UIColor darkGrayColor]];
    labelHeader.text = @"TRAVEL GUIDES";
    labelHeader.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:labelHeader];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.width * 0.48 + 8;
}

- (void)showDetail:(UIButton *)sender
{
    if (self.isLoadingProgress) {
        return;
    }
    
    self.selectedIndex = sender.tag / 10;
    //NSLog(@"Selected Row: %lu", (unsigned long)self.selectedIndex);
    
    [self performSegueWithIdentifier:@"GoToPopup" sender:sender];
}

//--------------------------------------------------------------------------------------------------------------
#pragma mark - Pop up

- (void)popupPressButton:(ELCityGuidePopupVC *)popup buttonType:(PopupButtonType)buttonType
{
    if (buttonType == PopupButtonFreePreview)
    {
        //NSLog(@"popupPressButton - Free Preview");

        self.isLoadingProgress = true;
        self.cityTableView.userInteractionEnabled = false;
        
        UIImageView *loadingImageView = (UIImageView *)[self.view viewWithTag:self.selectedIndex * 10 + 2];
        loadingImageView.hidden = false;
        [loadingImageView startAnimating];
        
        [self loadFreePreviewData];
    }
    else if (buttonType == PopupButtonPremiumGuides)
    {
        //NSLog(@"popupPressButton - Premium Guides");

        self.isLoadingProgress = true;
        self.cityTableView.userInteractionEnabled = false;
        
        UIImageView *loadingImageView = (UIImageView *)[self.view viewWithTag:self.selectedIndex * 10 + 2];
        loadingImageView.hidden = false;
        [loadingImageView startAnimating];
        
        [self loadPremiumGuidesData];
    }
    else if (buttonType == PopupButtonRestorePurchase)
    {
        //NSLog(@"popupPressButton - Restore Purchase");
    }
    else {
        //NSLog(@"None pressed");
    }
}

//--------------------------------------------------------------------------------------------------------------
- (void)loadFreePreviewData
{
    ELCity *city = self.cityList[self.selectedIndex];
    
//    [ELAPI getCityGuide:city.cityID withCompletionHandler:^(BOOL error, id result) {
//        
//    }];
  
    [ELAppData appData].cityID = city.cityID;
    [ELAppData appData].cityName = city.cityName;
    
    [[ELAppData appData] clearGuideCache];
    
    [ELAPI getAccomodationsFromCity:city.cityID type:@"2" withCompletionHandler:^(BOOL error, id result) {
        if (!error) {
            for (NSDictionary *dict in result[@"accommodations"])
            {
                ELPlaceGuide *accommodation = [ELPlaceGuide place:@"AccommodationGuide" withDictionary:dict];
                [[ELAppData appData].accommodationArray addObject:accommodation];
            }
            
            self.isLoadingProgress = false;
            self.cityTableView.userInteractionEnabled = true;
            
            UIImageView *loadingImageView = (UIImageView *)[self.view viewWithTag:self.selectedIndex * 10 + 2];
            loadingImageView.hidden = true;
            [loadingImageView stopAnimating];
            
            [self performSegueWithIdentifier:@"GoToCityGuide" sender:nil];
        }
        else {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error!"
                                                                           message:(NSString *)result
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { }];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}

- (void)loadPremiumGuidesData
{
    
}

- (void)stopLoading:(UIButton *)sender
{
    
}

//--------------------------------------------------------------------------------------------------------------
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ELCity *city = self.cityList[self.selectedIndex];

    if ([segue.identifier isEqualToString:@"GoToPopup"])
    {
        ELCityGuidePopupVC *vc = (ELCityGuidePopupVC *)segue.destinationViewController;
        [vc setCityName:city.cityName];
        [vc setIncomingTransition:incomingType];
        [vc setOutgoingTransition:outgoingType];
        [vc setDelegate:self];
        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:vc animated:NO completion:nil];
    }
    else if ([segue.identifier isEqualToString:@"GoToCityGuide"])
    {
//        [[NSUserDefaults standardUserDefaults] setObject:city.cityName forKey:@"CityName"];
//        [[NSUserDefaults standardUserDefaults] setObject:city.cityID forKey:@"CityID"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
