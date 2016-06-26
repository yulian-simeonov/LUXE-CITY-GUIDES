//
//  ELCityGuidePopupVC.m
//  ELITE CITY GUIDES
//
//  Created by Tony Parker on 5/6/16.
//  Copyright © 2016 eliteLYFE. All rights reserved.
//

#import "ELCityGuidePopupVC.h"


@interface ELCityGuidePopupVC() <UIGestureRecognizerDelegate> {
    CGFloat popupDimensionWidth;
    CGFloat popupDimensionHeight;
}

@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UIView *popupView;
@property (strong, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (strong, nonatomic) IBOutlet UIButton *freePreviewButton;
@property (strong, nonatomic) IBOutlet UIButton *premiumGuideButton;
@property (strong, nonatomic) IBOutlet UIButton *restorePurchaseButton;

@end


@implementation ELCityGuidePopupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.popupView.layer.cornerRadius = 4.0;
    [self.popupView.layer setMasksToBounds:YES];
    
    [self.freePreviewButton addTarget:self action:@selector(pressAlertButton:) forControlEvents:UIControlEventTouchUpInside];
    self.freePreviewButton.layer.cornerRadius = 4.0;
    
    [self.premiumGuideButton addTarget:self action:@selector(pressAlertButton:) forControlEvents:UIControlEventTouchUpInside];
    self.premiumGuideButton.layer.cornerRadius = 4.0;
    self.premiumGuideButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.premiumGuideButton.layer.borderWidth = 1.0;
    
    [self.restorePurchaseButton addTarget:self action:@selector(pressAlertButton:) forControlEvents:UIControlEventTouchUpInside];
    self.restorePurchaseButton.layer.cornerRadius = 4.0;
    self.restorePurchaseButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.restorePurchaseButton.layer.borderWidth = 1.0;
    
    self.cityNameLabel.text = self.cityName;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopup:)];
    [tap setDelegate:self];
    [self.backView addGestureRecognizer:tap];
}

- (void)viewDidLayoutSubviews
{
    popupDimensionWidth = self.popupView.frame.size.width;
    popupDimensionHeight = self.popupView.frame.size.height;
    
    [self showPopup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showPopup
{
    [self configureIncomingAnimationFor: self.incomingTransition ? self.incomingTransition : PopupIncomingTransitionTypeAppearCenter];
}

- (void)dismissPopup:(PopupButtonType)buttonType
{
    if (buttonType != PopupButtonFreePreview && buttonType != PopupButtonPremiumGuides && buttonType != PopupButtonRestorePurchase)
    {
        buttonType = PopupButtonNone;
    }
    
    [self configureOutgoingAnimationFor: self.outgoingTransition ? self.outgoingTransition : PopupOutgoingTransitionTypeDisappearCenter withButtonType:buttonType];
}

- (void)pressAlertButton:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    PopupButtonType buttonType;
    
    if ([button isEqual:self.freePreviewButton]) {
        buttonType = PopupButtonFreePreview;
    }
    else if ([button isEqual:self.premiumGuideButton]) {
        buttonType = PopupButtonPremiumGuides;
    }
    else {
        buttonType = PopupButtonRestorePurchase;
    }
    
    [self dismissPopup:buttonType];
}

#pragma mark - Transition Methods

- (void)configureIncomingAnimationFor:(PopupIncomingTransitionType)trannyType
{
    CGRect mainRect = CGRectMake(self.view.frame.size.width/2 - (popupDimensionWidth/2), self.view.frame.size.height/2 - (popupDimensionHeight/2), popupDimensionWidth, popupDimensionHeight);
    
    switch (trannyType) {
        case PopupIncomingTransitionTypeBounceFromCenter: {
            
            self.popupView.transform = CGAffineTransformMakeScale(0.4, 0.4);
            
            [UIView animateWithDuration:0.35 delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0 options:UIViewAnimationOptionTransitionNone animations:^{
                self.popupView.transform = CGAffineTransformIdentity;
                
            } completion:^(BOOL finished) {}];
            
            break;
        }
        case PopupIncomingTransitionTypeSlideFromLeft: {
            
            [self.popupView setFrame:CGRectMake(-popupDimensionWidth, self.view.frame.size.height/2 - (popupDimensionHeight/2), popupDimensionWidth, popupDimensionHeight)];
            
            [UIView animateWithDuration:0.125 animations:^{
                [self.popupView setFrame:mainRect];
                
            } completion:^(BOOL finished) {}];
            
            break;
        }
        case PopupIncomingTransitionTypeSlideFromTop: {
            
            [self.popupView setFrame:CGRectMake(self.view.frame.size.width/2 - (popupDimensionWidth/2), -popupDimensionHeight, popupDimensionWidth, popupDimensionHeight)];
            
            [UIView animateWithDuration:0.125 animations:^{
                [self.popupView setFrame:mainRect];
                
            } completion:^(BOOL finished) {}];
            
            break;
        }
        case PopupIncomingTransitionTypeSlideFromBottom: {
            
            [self.popupView setFrame:CGRectMake(self.view.frame.size.width/2 - (popupDimensionWidth/2), self.view.frame.size.height+popupDimensionHeight, popupDimensionWidth, popupDimensionHeight)];
            
            [UIView animateWithDuration:0.125 animations:^{
                [self.popupView setFrame:mainRect];
                
            } completion:^(BOOL finished) {}];
            
            break;
        }
        case PopupIncomingTransitionTypeSlideFromRight: {
            
            [self.popupView setFrame:CGRectMake(self.view.frame.size.width + popupDimensionWidth, self.view.frame.size.height/2 - (popupDimensionHeight/2), popupDimensionWidth, popupDimensionHeight)];
            
            [UIView animateWithDuration:0.125 animations:^{
                [self.popupView setFrame:mainRect];
                
            } completion:^(BOOL finished) {}];
            
            break;
        }
        case PopupIncomingTransitionTypeEaseFromCenter: {
            
            [self.popupView setAlpha:0.0];
            self.popupView.transform = CGAffineTransformMakeScale(0.75, 0.75);
            
            [UIView animateWithDuration:0.25 animations:^{
                self.popupView.transform = CGAffineTransformIdentity;
                [self.popupView setAlpha:1.0];
                
            } completion:^(BOOL finished) {}];
            
            break;
        }
        case PopupIncomingTransitionTypeAppearCenter: {
            
            [self.popupView setAlpha:0.0];
            
            [UIView animateWithDuration:0.05 animations:^{
                [self.popupView setAlpha:1.0];
                
            } completion:^(BOOL finished) {}];
            
            break;
        }
        case PopupIncomingTransitionTypeFallWithGravity: {
            
            [self.popupView setFrame:CGRectMake(self.view.frame.size.width/2 - (popupDimensionWidth/2), -popupDimensionHeight, popupDimensionWidth, popupDimensionHeight)];
            
            [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:0.9 options:UIViewAnimationOptionTransitionNone animations:^{
                [self.popupView setFrame:mainRect];
                
            } completion:^(BOOL finished) {}];
            
            break;
        }
        case PopupIncomingTransitionTypeGhostAppear: {
            
            [self.popupView setAlpha:0.0];
            
            [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^ {
                [self.popupView setAlpha:1.0];
                
            } completion:^(BOOL finished) {}];
            
            break;
        }
        case PopupIncomingTransitionTypeShrinkAppear: {
            
            [self.popupView setAlpha:0.0];
            self.popupView.transform = CGAffineTransformMakeScale(1.25, 1.25);
            
            [UIView animateWithDuration:0.25 animations:^{
                self.popupView.transform = CGAffineTransformIdentity;
                [self.popupView setAlpha:1.0];
                
            } completion:^(BOOL finished) {}];
            
            break;
        }
        default: {
            break;
        }
    }
}

- (void)configureOutgoingAnimationFor:(PopupOutgoingTransitionType)trannyType withButtonType:(PopupButtonType)buttonType
{
    //Make the blur/background fade away
    [UIView animateWithDuration:0.175 animations:^{
        [self.backView setAlpha:0.0];
    }];
    
    switch (trannyType) {
        case PopupOutgoingTransitionTypeBounceFromCenter: {
            
            [UIView animateWithDuration:0.1 delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0 options:UIViewAnimationOptionTransitionNone animations:^{
                self.popupView.transform = CGAffineTransformMakeScale(1.15, 1.15);
                
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 animations:^{
                    
                    self.popupView.transform = CGAffineTransformMakeScale(0.75, 0.75);
                    
                } completion:^(BOOL finished) {
                    [self endWithButtonType:buttonType];
                }];
            }];
            
            break;
        }
        case PopupOutgoingTransitionTypeSlideToLeft: {
            
            CGRect rect = CGRectMake(-popupDimensionWidth, self.view.frame.size.height/2 - (popupDimensionHeight/2), popupDimensionWidth, popupDimensionHeight);
            
            [UIView animateWithDuration:0.125 animations:^{
                [self.popupView setFrame:rect];
                
            } completion:^(BOOL finished) {
                [self endWithButtonType:buttonType];
            }];
            
            break;
        }
        case PopupOutgoingTransitionTypeSlideToTop: {
            
            CGRect rect = CGRectMake(self.view.frame.size.width/2 - (popupDimensionWidth/2), -popupDimensionHeight, popupDimensionWidth, popupDimensionHeight);
            
            [UIView animateWithDuration:0.125 animations:^{
                [self.popupView setFrame:rect];
                
            } completion:^(BOOL finished) {
                [self endWithButtonType:buttonType];
                
            }];
            
            break;
        }
        case PopupOutgoingTransitionTypeSlideToBottom: {
            
            CGRect rect = CGRectMake(self.view.frame.size.width/2 - (popupDimensionWidth/2), self.view.frame.size.height + popupDimensionHeight, popupDimensionWidth, popupDimensionHeight);
            
            [UIView animateWithDuration:0.125 animations:^{
                [self.popupView setFrame:rect];
                
            } completion:^(BOOL finished) {
                [self endWithButtonType:buttonType];
                
            }];
            
            break;
        }
        case PopupOutgoingTransitionTypeSlideToRight: {
            
            CGRect rect = CGRectMake(self.view.frame.size.width + popupDimensionWidth, self.view.frame.size.height/2 - (popupDimensionHeight/2), popupDimensionWidth, popupDimensionHeight);
            
            [UIView animateWithDuration:0.125 animations:^{
                [self.popupView setFrame:rect];
                
            } completion:^(BOOL finished) {
                [self endWithButtonType:buttonType];
            }];
            
            break;
        }
        case PopupOutgoingTransitionTypeEaseToCenter: {
            
            [UIView animateWithDuration:0.2 animations:^{
                self.popupView.transform = CGAffineTransformMakeScale(0.75, 0.75);
                [self.popupView setAlpha:0.0];
                
            } completion:^(BOOL finished) {
                [self endWithButtonType:buttonType];
            }];
            
            break;
        }
        case PopupOutgoingTransitionTypeDisappearCenter: {
            
            [UIView animateWithDuration:0.25 animations:^{
                self.popupView.transform = CGAffineTransformMakeScale(0.65, 0.65);
                [self.popupView setAlpha:0.0];
                
            } completion:^(BOOL finished) {
                [self endWithButtonType:buttonType];
            }];
            
            break;
        }
        case PopupOutgoingTransitionTypeFallWithGravity: {
            
            CGRect initialRect = CGRectMake(self.view.frame.size.width/2 - (popupDimensionWidth/2), self.view.frame.size.height/2 - (popupDimensionHeight/2), popupDimensionWidth, popupDimensionHeight);
            CGRect endingRect = CGRectMake(self.view.frame.size.width/2 - (popupDimensionWidth/2), self.view.frame.size.height + popupDimensionHeight, popupDimensionWidth, popupDimensionHeight);
            
            [UIView animateWithDuration:0.1 delay:0.0 usingSpringWithDamping:0.24 initialSpringVelocity:0.9 options:UIViewAnimationOptionTransitionNone animations:^{
                [self.popupView setFrame:initialRect];
                
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.35 animations:^{
                    [self.popupView setFrame:endingRect];
                    
                } completion:^(BOOL finished) {
                    [self endWithButtonType:buttonType];
                }];
            }];
            
            break;
        }
        case PopupOutgoingTransitionTypeGhostDisappear: {
            
            [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                [self.popupView setAlpha:0.0];
                
            } completion:^(BOOL finished) {
                [self endWithButtonType:buttonType];
            }];
            
            break;
        }
        case PopupOutgoingTransitionTypeGrowDisappear: {
            
            [UIView animateWithDuration:0.25 animations:^{
                self.popupView.transform = CGAffineTransformMakeScale(1.25, 1.25);
                [self.popupView setAlpha:0.0];
                
            } completion:^(BOOL finished) {
                [self endWithButtonType:buttonType];
            }];
            
            break;
        }
        default: {
            break;
        }
    }
}

- (void)endWithButtonType:(PopupButtonType)buttonType
{
    if ([self.delegate respondsToSelector:@selector(popupPressButton:buttonType:)]) {
        [self.delegate popupPressButton:self buttonType:buttonType];
    }
    
    [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
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
