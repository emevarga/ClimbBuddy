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
#import "ToggleSegmentedControl.h"
#import "ClimbFetcher.h"
#import "SearchResultViewController.h"


const NSString *kSearchControlDistanceControl = @"distance";
const NSString *kSearchControlTypeControl = @"type";
const NSString *kSearchControlDifficultySlider = @"difficulty";
const NSString *kSearchControlHeightSlider = @"height";
const NSString *kSearchControlSearchButton = @"search button";

@interface SearchViewController (Internal)
-(CGRect)getLabelRectForOffset:(CGFloat)offset;
-(CGRect)getControlRectForOffset:(CGFloat)offset;

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

-(void)loadView{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    if(!_searchControls){
        _searchControls = [[NSMutableDictionary alloc]initWithCapacity:5];
    }
    CGFloat controlSectionHeight = 70;
    CGFloat offset = 10;

    UILabel *distanceLabel = [ClimbersBuddyStyle getLabelWithSearchFormatting];
    distanceLabel.frame = [self getLabelRectForOffset:offset];
    [distanceLabel setText:@"Distance from location:"];
    [self.view addSubview:distanceLabel];
    
    NSArray *distanceItems = @[@"20 miles",@"50 miles",@"100 miles",@"500 miles"];
    ToggleSegmentedControl *distanceControl = [[ToggleSegmentedControl alloc]initWithItems:distanceItems];
    distanceControl.frame = [self getControlRectForOffset:offset];
    [distanceControl setTitleTextAttributes:@{ UITextAttributeFont : [UIFont systemFontOfSize:12] } forState:UIControlStateNormal];
    [self.view addSubview:distanceControl];
    [_searchControls setObject:distanceControl forKey:kSearchControlDistanceControl];
    
    offset += controlSectionHeight;
    UILabel *typeLabel = [ClimbersBuddyStyle getLabelWithSearchFormatting];
    typeLabel.frame = [self getLabelRectForOffset:offset];
    [typeLabel setText:@"Climb type:"];
    [self.view addSubview:typeLabel];
    
    NSArray *typeItems = @[@"Boulder",@"Top Rope",@"Lead",@"Trad."];
    ToggleSegmentedControl *typeControl = [[ToggleSegmentedControl alloc]initWithItems:typeItems];
    [typeControl setTitleTextAttributes:@{ UITextAttributeFont : [UIFont systemFontOfSize:12] } forState:UIControlStateNormal];
    typeControl.frame = [self getControlRectForOffset:offset];
    [self.view addSubview:typeControl];
    [_searchControls setObject:typeItems forKey:kSearchControlTypeControl];
    
    
    offset += controlSectionHeight;
    UILabel *difficultyLabel = [ClimbersBuddyStyle getLabelWithSearchFormatting];
    difficultyLabel.frame = [self getLabelRectForOffset:offset];
    [difficultyLabel setText:@"Max Difficulty:"];
    [self.view addSubview:difficultyLabel];
    
    UISlider *difficultySlider = [[UISlider alloc]initWithFrame:[self getControlRectForOffset:offset]];
    [self.view addSubview:difficultySlider];
    [_searchControls setObject:difficultySlider forKey:kSearchControlDifficultySlider];
    
    offset += controlSectionHeight;
    
    UILabel *heightLabel = [ClimbersBuddyStyle getLabelWithSearchFormatting];
    heightLabel.frame = [self getLabelRectForOffset:offset];
    [heightLabel setText:@"Max Height:"];
    [self.view addSubview:heightLabel];
    
    UISlider *heightSlider = [[UISlider alloc]initWithFrame:[self getControlRectForOffset:offset]];
    [self.view addSubview:heightSlider];
    [_searchControls setObject:heightSlider forKey:kSearchControlHeightSlider];
    
    offset += controlSectionHeight;
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [searchButton setTitle:@"Search" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    searchButton.frame = CGRectMake(CONTROL_HORIZONTAL_PADDING, offset+LABEL_PADDING*4, 320-CONTROL_HORIZONTAL_PADDING*2, 40);
    [searchButton addTarget:self action:@selector(searchButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:searchButton];
    [_searchControls setObject:searchButton forKey:kSearchControlSearchButton];

}

-(CGRect)getLabelRectForOffset:(CGFloat)offset{
    return CGRectMake(CONTROL_HORIZONTAL_PADDING, offset+CONTROL_VERTICAL_PADDING, SEARCH_CONTROL_WIDTH, LABEL_HEIGHT);
}

-(CGRect)getControlRectForOffset:(CGFloat)offset{
    return CGRectMake(CONTROL_HORIZONTAL_PADDING, offset+CONTROL_VERTICAL_PADDING+LABEL_PADDING+LABEL_HEIGHT, SEARCH_CONTROL_WIDTH, SEARCH_CONTROL_HEIGHT);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
