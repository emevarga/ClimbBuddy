//
//  SearchViewController.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/21/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "SearchViewController.h"

#import "CommonDefines.h"
#import "ClimbersBuddyStyle.h"
#import "ClimbFetcher.h"
#import "SearchResultViewController.h"
#import "RangeSlider.h"
#import <QuartzCore/QuartzCore.h>


const NSString *kSearchControlDistanceControl = @"distance";
const NSString *kSearchControlTypeControl = @"type";
const NSString *kSearchControlDifficultySlider = @"difficulty";
const NSString *kSearchControlHeightSlider = @"height";
const NSString *kSearchControlSearchButton = @"search button";

@interface SearchViewController (Internal)
-(CGRect)getLabelRectForOffset:(CGFloat)offset;
-(CGRect)getControlRectForOffset:(CGFloat)offset;

-(void)difficultySliderChanged:(RangeSlider *)rangeSlider;
-(void)searchButtonPressed;
@end

@implementation SearchViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"Search";
        self.tabBarItem.image = [UIImage imageNamed:@"SearchIcon.png"];
    }
    return self;
}

-(void)searchButtonPressed{
    NSArray *climbs = [ClimbFetcher getClimbsFor:nil];
    SearchResultViewController *climbInfoView = [[SearchResultViewController alloc] initWithClimbs:climbs];
    [self.navigationController pushViewController:climbInfoView animated:YES];
    
    //create search filter
    //create view with search filter
    //push view with search results
}

-(void)difficultySliderChanged:(RangeSlider *)rangeSlider{

}

-(void)loadView{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    if(!_searchControls){
        _searchControls = [[NSMutableDictionary alloc]initWithCapacity:5];
    }
    CGFloat controlSectionHeight = 70;
    CGFloat offset = 10;
    
    UILabel *filterLabel = [ClimbersBuddyStyle getLabelWithSearchFormatting];
    filterLabel.frame = [self getLabelRectForOffset:offset];
    [filterLabel setText:@"Sort results by:"];
    [self.view addSubview:filterLabel];
    
    NSArray *filterItems = @[@"Best Match",@"Nearest",@"Most Difficult"];
    UISegmentedControl *filterControl = [ClimbersBuddyStyle getSegmentedControlWithItems:filterItems withToggle:NO];
    [filterControl setSelectedSegmentIndex:0];
    filterControl.frame = [self getControlRectForOffset:offset];
    [self.view addSubview:filterControl];
    //add to control dictionary
    offset += controlSectionHeight;

    UILabel *distanceLabel = [ClimbersBuddyStyle getLabelWithSearchFormatting];
    distanceLabel.frame = [self getLabelRectForOffset:offset];
    [distanceLabel setText:@"Max miles from location:"];
    [self.view addSubview:distanceLabel];
    
    NSArray *distanceItems = @[@"5",@"25",@"50",@"100"];
    UISegmentedControl *distanceControl = [ClimbersBuddyStyle getSegmentedControlWithItems:distanceItems withToggle:YES];
    distanceControl.frame = [self getControlRectForOffset:offset];
    [self.view addSubview:distanceControl];
    [_searchControls setObject:distanceControl forKey:kSearchControlDistanceControl];
    
    offset += controlSectionHeight;
    UILabel *typeLabel = [ClimbersBuddyStyle getLabelWithSearchFormatting];
    typeLabel.frame = [self getLabelRectForOffset:offset];
    [typeLabel setText:@"Climb type:"];
    [self.view addSubview:typeLabel];
    
    NSArray *typeItems = @[@"Boulder",@"Top Rope",@"Lead",@"Trad."];
    UISegmentedControl *typeControl = [ClimbersBuddyStyle getSegmentedControlWithItems:typeItems withToggle:YES];
    typeControl.frame = [self getControlRectForOffset:offset];
    [self.view addSubview:typeControl];
    [_searchControls setObject:typeItems forKey:kSearchControlTypeControl];
    
    
    offset += controlSectionHeight;
    UILabel *difficultyLabel = [ClimbersBuddyStyle getLabelWithSearchFormatting];
    difficultyLabel.frame = [self getLabelRectForOffset:offset];
    [difficultyLabel setText:@"Max Difficulty:"];
    [self.view addSubview:difficultyLabel];
    
    CGRect rangeSliderRect = [self getControlRectForOffset:offset];
    RangeSlider *difficultySlider = [ClimbersBuddyStyle getRangeSlider:rangeSliderRect];
    [difficultySlider addTarget:self action:@selector(difficultySliderChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:difficultySlider];
    [_searchControls setObject:difficultySlider forKey:kSearchControlDifficultySlider];
    
    offset += controlSectionHeight;
    
    UIButton *searchButton = [ClimbersBuddyStyle getButtonForSearch];
    searchButton.frame = CGRectMake(CONTROL_HORIZONTAL_PADDING, offset+SEARCH_LABEL_PADDING*4, 320-CONTROL_HORIZONTAL_PADDING*2, 40);
    [searchButton addTarget:self action:@selector(searchButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    CALayer *gradientLayer = [ClimbersBuddyStyle getGradientForLayer:searchButton.layer];
    [searchButton.layer insertSublayer:gradientLayer atIndex:0];
    [self.view addSubview:searchButton];
    [_searchControls setObject:searchButton forKey:kSearchControlSearchButton];

}

-(CGRect)getLabelRectForOffset:(CGFloat)offset{
    return CGRectMake(CONTROL_HORIZONTAL_PADDING, offset+CONTROL_VERTICAL_PADDING, SEARCH_CONTROL_WIDTH, SEARCH_LABEL_HEIGHT);
}

-(CGRect)getControlRectForOffset:(CGFloat)offset{
    return CGRectMake(CONTROL_HORIZONTAL_PADDING, offset+CONTROL_VERTICAL_PADDING+SEARCH_LABEL_PADDING+SEARCH_LABEL_HEIGHT, SEARCH_CONTROL_WIDTH, SEARCH_CONTROL_HEIGHT);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
