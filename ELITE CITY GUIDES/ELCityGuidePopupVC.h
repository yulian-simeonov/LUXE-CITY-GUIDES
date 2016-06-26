//
//  ELCityGuidePopupVC.h
//  ELITE CITY GUIDES
//
//  Created by Tony Parker on 5/6/16.
//  Copyright © 2016 eliteLYFE. All rights reserved.
//

#import <UIKit/UIKit.h>


//Popup button types
typedef NS_ENUM(NSInteger, PopupButtonType) {
    PopupButtonFreePreview = 0,
    PopupButtonPremiumGuides,
    PopupButtonRestorePurchase,
    PopupButtonNone
};

//Incoming transition types
typedef NS_ENUM(NSUInteger, PopupIncomingTransitionType) {
    PopupIncomingTransitionTypeBounceFromCenter = 1,
    PopupIncomingTransitionTypeSlideFromLeft,
    PopupIncomingTransitionTypeSlideFromTop,
    PopupIncomingTransitionTypeSlideFromBottom,
    PopupIncomingTransitionTypeSlideFromRight,
    PopupIncomingTransitionTypeEaseFromCenter,
    PopupIncomingTransitionTypeAppearCenter,
    PopupIncomingTransitionTypeFallWithGravity,
    PopupIncomingTransitionTypeGhostAppear,
    PopupIncomingTransitionTypeShrinkAppear
};

//Outgoing transition types
typedef NS_ENUM(NSUInteger, PopupOutgoingTransitionType) {
    PopupOutgoingTransitionTypeBounceFromCenter = 1,
    PopupOutgoingTransitionTypeSlideToLeft,
    PopupOutgoingTransitionTypeSlideToTop,
    PopupOutgoingTransitionTypeSlideToBottom,
    PopupOutgoingTransitionTypeSlideToRight,
    PopupOutgoingTransitionTypeEaseToCenter,
    PopupOutgoingTransitionTypeDisappearCenter,
    PopupOutgoingTransitionTypeFallWithGravity,
    PopupOutgoingTransitionTypeGhostDisappear,
    PopupOutgoingTransitionTypeGrowDisappear
};

//Block for success and cancel buttons
typedef void (^blocky)(void);


@class ELCityGuidePopupVC;

@protocol PopupDelegate <NSObject>

@optional
//Figure out what button was pressed on your Popup
- (void)popupPressButton:(ELCityGuidePopupVC *)popup buttonType:(PopupButtonType)buttonType;

@end

@interface ELCityGuidePopupVC : UIViewController

@property (nonatomic, weak) id <PopupDelegate> delegate;

//The transitions for Popup
@property (nonatomic, assign) PopupIncomingTransitionType incomingTransition;
@property (nonatomic, assign) PopupOutgoingTransitionType outgoingTransition;

@property (nonatomic, assign) NSString *cityName;

@end
