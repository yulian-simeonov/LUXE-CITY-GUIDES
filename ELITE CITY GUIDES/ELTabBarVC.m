//
//  ELTabBarVC.m
//  ELITE CITY GUIDES
//
//  Created by Tony Parker on 5/8/16.
//  Copyright © 2016 eliteLYFE. All rights reserved.
//

#import "ELTabBarVC.h"
#import "UIImage+ImageUtils.h"


@interface ELTabBarVC ()

@property (nonatomic) CGSize tabBarSize;
@property (nonatomic, strong) UIImage *selected_1;
@property (nonatomic, strong) UIImage *selected_2;
@property (nonatomic, strong) UIImage *selected_3;
@property (nonatomic, strong) UIImage *selected_4;
@property (nonatomic, strong) UIImage *selected_5;

@end


@implementation ELTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBarSize = self.tabBar.frame.size;
    
    self.selected_1 = [UIImage imageWithImage:[UIImage imageNamed:@"tabbar_select_1"] scaledToSize:self.tabBarSize];
    self.selected_2 = [UIImage imageWithImage:[UIImage imageNamed:@"tabbar_select_2"] scaledToSize:self.tabBarSize];
    self.selected_3 = [UIImage imageWithImage:[UIImage imageNamed:@"tabbar_select_3"] scaledToSize:self.tabBarSize];
    self.selected_4 = [UIImage imageWithImage:[UIImage imageNamed:@"tabbar_select_4"] scaledToSize:self.tabBarSize];
    self.selected_5 = [UIImage imageWithImage:[UIImage imageNamed:@"tabbar_select_5"] scaledToSize:self.tabBarSize];

    [self.tabBar setBackgroundImage:self.selected_1];
    
    self.tabBar.barTintColor = [UIColor whiteColor];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
}

//--------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_button_shadow"] style:UIBarButtonItemStylePlain target:nil action:nil];
    
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
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSArray *barItems = self.tabBar.items;
    NSInteger selected = [barItems indexOfObject:item];
    
    if (selected == 0) {
        [self.tabBar setBackgroundImage:self.selected_1];
    }
    else if (selected == 1) {
        [self.tabBar setBackgroundImage:self.selected_2];
    }
    else if (selected == 2) {
        [self.tabBar setBackgroundImage:self.selected_3];
    }
    else if (selected == 3) {
        [self.tabBar setBackgroundImage:self.selected_4];
    }
    else if (selected == 4) {
        [self.tabBar setBackgroundImage:self.selected_5];
    }
}

//--------------------------------------------------------------------------------------------------------------
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}

@end
