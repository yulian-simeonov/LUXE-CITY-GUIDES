//
//  ELCitiesLoadVC.m
//  ELITE CITY GUIDES
//
//  Created by Yavor Krastev on 5/18/16.
//  Copyright © 2016 eliteLYFE. All rights reserved.
//

#import "ELCitiesLoadVC.h"
#import "ELAPI.h"
#import "ELAppData.h"
#import "ELCity.h"


@interface ELCitiesLoadVC ()

@property (strong, nonatomic) IBOutlet UIImageView *loadingIconView;

@end


@implementation ELCitiesLoadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.loadingIconView.animationImages = [NSArray arrayWithObjects:
                                            [UIImage imageNamed:@"loading_icon_1"],
                                            [UIImage imageNamed:@"loading_icon_2"],
                                            [UIImage imageNamed:@"loading_icon_3"],
                                            [UIImage imageNamed:@"loading_icon_4"],
                                            [UIImage imageNamed:@"loading_icon_5"],
                                            [UIImage imageNamed:@"loading_icon_6"],
                                            [UIImage imageNamed:@"loading_icon_7"],
                                            [UIImage imageNamed:@"loading_icon_8"],
                                            nil];
    
    self.loadingIconView.animationDuration = 1;
    self.loadingIconView.animationRepeatCount = 0;
    [self.loadingIconView startAnimating];
    
    [self loadInformation];
}

//-------------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-------------------------------------------------------------------------------------------------------------------------
- (void)loadInformation
{
    [[ELAppData appData] clearListCache];
    
    [ELAPI getCitiesWithCompletionHandler:^(BOOL error, id result)
     {
         if (!error)
         {
             for (NSDictionary *dict in result[@"cities"])
             {
                 ELCity *city = [ELCity cityWithDictionary:dict];
                 [[ELAppData appData].cityList addObject:city];
             }
             
             [self performSegueWithIdentifier:@"GoToExplore" sender:nil];
         }
         else
         {
             UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error!"
                                                                            message:(NSString *)result
                                                                     preferredStyle:UIAlertControllerStyleAlert];
             UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { }];
             [alert addAction:defaultAction];
             [self presentViewController:alert animated:YES completion:nil];
         }
     }];
}

//-------------------------------------------------------------------------------------------------------------------------
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"GoToExplore"])
    {
        [self.loadingIconView stopAnimating];
    }
}

@end
