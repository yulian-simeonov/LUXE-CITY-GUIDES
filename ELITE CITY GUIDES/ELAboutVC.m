//
//  ELAboutVC.m
//  ELITE CITY GUIDES
//
//  Created by Tony Parker on 5/6/16.
//  Copyright © 2016 eliteLYFE. All rights reserved.
//

#import "ELAboutVC.h"


@interface ELAboutVC ()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIView *infoView;
@property (strong, nonatomic) IBOutlet UITextView *detailTextView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *infoHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *textHeightConstraint;

@end


@implementation ELAboutVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

//--------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
}

- (void)viewDidLayoutSubviews
{
    CGFloat textHeight = self.detailTextView.contentSize.height;
    self.textHeightConstraint.constant = textHeight;
    
    self.infoHeightConstraint.constant = textHeight + 10;
    
    CGRect contentRect = self.scrollView.frame;
    contentRect.size.height = self.infoHeightConstraint.constant;
    self.scrollView.contentSize = contentRect.size;
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
