//
//  SearchViewController.h
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/21/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const NSString *kSearchControlDistanceControl;
extern const NSString *kSearchControlTypeControl;
extern const NSString *kSearchControlDifficultySlider;
extern const NSString *kSearchControlSearchButton;
extern const NSString *kSearchControlDifficultyLabel;

@interface SearchViewController : UIViewController{
    NSMutableDictionary *_searchControls;
    UILabel *_minDifficultyLabel;
    UILabel *_maxDifficultyLabel;
}

@end
