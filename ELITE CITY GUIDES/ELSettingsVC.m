//
//  ELSettingsVC.m
//  ELITE CITY GUIDES
//
//  Created by Yavor Krastev on 5/6/16.
//  Copyright © 2016 eliteLYFE. All rights reserved.
//

#import "ELSettingsVC.h"


@interface ELSettingsVC ()

@property (strong, nonatomic) NSArray *currencyMode;
@property (strong, nonatomic) NSArray *languageMode;

@property (strong, nonatomic) IBOutlet UILabel *currencyLabel;
@property (strong, nonatomic) IBOutlet UIButton *prevCurrencyButton;
@property (strong, nonatomic) IBOutlet UIButton *nextCurrencyButton;

@property (strong, nonatomic) IBOutlet UILabel *languageLabel;
@property (strong, nonatomic) IBOutlet UIButton *prevLanguageButton;
@property (strong, nonatomic) IBOutlet UIButton *nextLanguageButton;

@property (strong, nonatomic) IBOutlet UISegmentedControl *distanceUnitSegment;
@property (strong, nonatomic) IBOutlet UISwitch *adTrackingSwitch;

@end


@implementation ELSettingsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.currencyMode = @[@"PEN (S/.)", @"PGK (K)", @"PHP ()", @"PLN ()", @"RUB ()", @"SAR ()", @"SCR (SR)", @"SEK (kr)", @"SGD (S$)", @"THB ()", @"TND (TND)", @"TRY (TL)", @"TWD (NT$)", @"TZS (TSh)", @"USD ($)", @"UYU ($U)", @"VND ()", @"WST ($)", @"XCD ($)", @"XPF (F)", @"ZAR (R)"];
    
    self.languageMode = @[@"English", @"French", @"Chinese"];
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
- (IBAction)onClickPrevCurrency:(id)sender
{
    NSInteger index = [self.currencyMode indexOfObject:self.currencyLabel.text];
    
    if (index > 0)
    {
        index = index - 1;
        self.currencyLabel.text = [self.currencyMode objectAtIndex:index];
        
        [self.nextCurrencyButton setImage:[UIImage imageNamed:@"rightTriArrow_icon"] forState:UIControlStateNormal];
        self.nextCurrencyButton.enabled = true;
        if (index == 0)
        {
            [self.prevCurrencyButton setImage:[UIImage imageNamed:@"leftTriEmptyArrow_icon"] forState:UIControlStateNormal];
            self.prevCurrencyButton.enabled = false;
        }
    }
}

- (IBAction)onClickNextCurrency:(id)sender
{
    NSInteger index = [self.currencyMode indexOfObject:self.currencyLabel.text];
    
    if (index < [self.currencyMode count] - 1)
    {
        index = index + 1;
        self.currencyLabel.text = [self.currencyMode objectAtIndex:index];
        
        [self.prevCurrencyButton setImage:[UIImage imageNamed:@"leftTriArrow_icon"] forState:UIControlStateNormal];
        self.prevCurrencyButton.enabled = true;
        if (index == [self.currencyMode count] - 1)
        {
            [self.nextCurrencyButton setImage:[UIImage imageNamed:@"rightTriEmptyArrow_icon"] forState:UIControlStateNormal];
            self.nextCurrencyButton.enabled = false;
        }
    }
}

//--------------------------------------------------------------------------------------------------------------
- (IBAction)onClickPrevLanguage:(id)sender
{
    NSInteger index = [self.languageMode indexOfObject:self.languageLabel.text];
    
    if (index > 0)
    {
        index = index - 1;
        self.languageLabel.text = [self.languageMode objectAtIndex:index];
        
        [self.nextLanguageButton setImage:[UIImage imageNamed:@"rightTriArrow_icon"] forState:UIControlStateNormal];
        self.nextLanguageButton.enabled = true;
        if (index == 0)
        {
            [self.prevLanguageButton setImage:[UIImage imageNamed:@"leftTriEmptyArrow_icon"] forState:UIControlStateNormal];
            self.prevLanguageButton.enabled = false;
        }
    }
}

- (IBAction)onClickNextLanguage:(id)sender
{
    NSInteger index = [self.languageMode indexOfObject:self.languageLabel.text];
    
    if (index < [self.languageMode count] - 1)
    {
        index = index + 1;
        self.languageLabel.text = [self.languageMode objectAtIndex:index];
        
        [self.prevLanguageButton setImage:[UIImage imageNamed:@"leftTriArrow_icon"] forState:UIControlStateNormal];
        self.prevLanguageButton.enabled = true;
        if (index == [self.languageMode count] - 1)
        {
            [self.nextLanguageButton setImage:[UIImage imageNamed:@"rightTriEmptyArrow_icon"] forState:UIControlStateNormal];
            self.nextLanguageButton.enabled = false;
        }
    }
}

//--------------------------------------------------------------------------------------------------------------


//--------------------------------------------------------------------------------------------------------------



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
