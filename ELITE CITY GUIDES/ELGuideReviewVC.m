//
//  ELGuideReviewVC.m
//  ELITE CITY GUIDES
//
//  Created by Tony Parker on 5/22/16.
//  Copyright © 2016 eliteLYFE. All rights reserved.
//

#import "ELGuideReviewVC.h"


@interface ELGuideReviewVC ()

@end


@implementation ELGuideReviewVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
