//
//  ELMoreVC.m
//  ELITE CITY GUIDES
//
//  Created by Yavor Krastev on 5/8/16.
//  Copyright © 2016 eliteLYFE. All rights reserved.
//

#import "ELMoreVC.h"

@interface ELMoreVC ()

@end

@implementation ELMoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//--------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
}

- (void)viewDidLayoutSubviews
{
    //    CGFloat width = self.view.frame.size.width;
    //    self.headerWidthConstraint.constant = width / 4;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
