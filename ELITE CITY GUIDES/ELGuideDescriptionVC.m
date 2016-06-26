//
//  ELGuideDescriptionVC.m
//  ELITE CITY GUIDES
//
//  Created by Tony Parker on 5/22/16.
//  Copyright © 2016 eliteLYFE. All rights reserved.
//

#import "ELGuideDescriptionVC.h"


@interface ELGuideDescriptionVC ()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIView *infoView;
@property (strong, nonatomic) IBOutlet UITextView *detailTextView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *infoHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *textHeightConstraint;

@property (strong, nonatomic) IBOutlet UILabel *guideNameLabel;
@property (strong, nonatomic) IBOutlet UIView *guideRatingView;
@property (strong, nonatomic) IBOutlet UITextView *guideDescTextView;

@end


@implementation ELGuideDescriptionVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.guideNameLabel.text = self.guideName;
    self.guideDescTextView.text = self.guideDescription;
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
    
    self.infoHeightConstraint.constant = self.detailTextView.frame.origin.y + textHeight + 20;
    
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
