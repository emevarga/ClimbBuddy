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
#import "SearchResultViewController.h"
#import "RangeSlider.h"
#import "SearchFilter.h"
#import <QuartzCore/QuartzCore.h>
#import "LocationManager.h"


#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


const NSString *kSearchControlDistanceControl = @"distance";
const NSString *kSearchControlTypeControl = @"type";
const NSString *kSearchControlDifficultySlider = @"difficulty";
const NSString *kSearchControlHeightSlider = @"height";
const NSString *kSearchControlSearchButton = @"search button";
const NSString *kSearchControlFilterControl = @"filter";

@interface SearchViewController (Internal)
-(NSArray *)getConstraints;
-(CGRect)getLabelRectForOffset:(CGFloat)offset;
-(CGRect)getControlRectForOffset:(CGFloat)offset;

-(void)difficultySliderChanged:(RangeSlider *)rangeSlider;
-(void)typeChanged:(UISegmentedControl *)typeControl;
-(void)updateLabels;
-(void)searchButtonPressed;

-(SearchFilter *)generateFilter;
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

-(NSString *)filterTypeForIndex:(NSInteger)index{
    NSString *filterType = nil;
    if(index == 0){
        filterType = @"closest";
    }else if(index == 1){
        filterType = @"best_match";
    }else if(index == 2){
        filterType = @"hardest";
    }
    return filterType;
}

-(SearchFilter *)generateFilter{
    UISegmentedControl *typeControl = [_searchControls objectForKey:kSearchControlTypeControl];
    ClimbType type = [ClimbersBuddyStyle getTypeForIndex:typeControl.selectedSegmentIndex];
    NSString *typeString = [ClimbersBuddyStyle getStringForTypeEnum:type];
    
    RangeSlider *difficultySlider = [_searchControls objectForKey:kSearchControlDifficultySlider];
    NSUInteger minDifficulty = ceil(difficultySlider.selectedMinimumValue);
    NSUInteger maxDifficulty = ceil(difficultySlider.selectedMaximumValue);
    
    UISegmentedControl *distanceControl = [_searchControls objectForKey:kSearchControlDistanceControl];
    NSInteger maxDistance = -1;
    if(distanceControl.selectedSegmentIndex != -1){
        maxDistance = [ClimbersBuddyStyle milesForSegment:distanceControl.selectedSegmentIndex];
    }
    UISegmentedControl *filterControl = [_searchControls objectForKey:kSearchControlFilterControl];
    NSString *filterType = [self filterTypeForIndex:filterControl.selectedSegmentIndex];
    return [[SearchFilter alloc]initFor:typeString withMinDifficulty:minDifficulty maxDifficulty:maxDifficulty maxDistance:maxDistance filterType:filterType];
}


-(void)searchButtonPressed{
    SearchFilter *filter = [self generateFilter];
    SearchResultViewController *climbInfoView = [[SearchResultViewController alloc] initWithSearchFilter:filter];
    [self.navigationController pushViewController:climbInfoView animated:YES];
}

-(void)difficultySliderChanged:(RangeSlider *)rangeSlider{
    [self updateLabels];
}

-(void)typeChanged:(UISegmentedControl *)typeControl{
    RangeSlider *rangeSlider = [_searchControls objectForKey:kSearchControlDifficultySlider];
    NSInteger size;
    if(typeControl.selectedSegmentIndex == 0){
        size = [[ClimbInfo getBoulderDifficulties]count];
    }else{
        size = [[ClimbInfo getRopedDifficulties]count];
    }
    size--;
    [rangeSlider setMinimumValue:0];
    [rangeSlider setMaximumValue:size];
    [self updateLabels];
}

-(void)updateLabels{
    RangeSlider *rangeSlider = [_searchControls objectForKey:kSearchControlDifficultySlider];
    NSInteger lowerValue = ceil(rangeSlider.selectedMinimumValue);
    NSInteger upperValue = ceil(rangeSlider.selectedMaximumValue);
    UISegmentedControl *typeControl = [_searchControls objectForKey:kSearchControlTypeControl];
    NSArray *difficultyStrings;
    if(typeControl.selectedSegmentIndex == 0){
        difficultyStrings = [ClimbInfo getBoulderDifficulties];
    }else{
        difficultyStrings = [ClimbInfo getRopedDifficulties];
    }
    [_minDifficultyLabel setText:[difficultyStrings objectAtIndex:lowerValue]];
    [_maxDifficultyLabel setText:[difficultyStrings objectAtIndex:upperValue]];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self typeChanged:[_searchControls objectForKey:kSearchControlTypeControl]];
    LocationManager *locationManager = [LocationManager getInstance];
    [locationManager start];
}

-(void)loadView{
    [super loadView];
    UIColor *segmentTextColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        segmentTextColor = [UIColor darkGrayColor];
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    if ([self respondsToSelector:@selector(setExtendedLayoutIncludesOpaqueBars:)]) {
        self.extendedLayoutIncludesOpaqueBars = YES;
    }
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.view.layer.masksToBounds = YES;
    if(!_searchControls){
        _searchControls = [[NSMutableDictionary alloc]initWithCapacity:5];
    }
    CGFloat controlSectionHeight = 70;
    CGFloat offset;
    if(IS_IPHONE_5){
        offset = 30;
    }else{
        offset = 10;
    }
    
    //add to control dictionary
    
    UILabel *filterLabel = [ClimbersBuddyStyle getLabelWithSearchFormatting];
    filterLabel.frame = [self getLabelRectForOffset:offset];
    [filterLabel setText:@"Sort results by:"];
    [self.view addSubview:filterLabel];
    
    NSArray *filterItems = @[@"Nearest",@"Best Match",@"Most Difficult"];
    UISegmentedControl *filterControl = [ClimbersBuddyStyle getSegmentedControlWithItems:filterItems withToggle:NO];
    [filterControl setTitleTextAttributes:@{UITextAttributeTextColor : segmentTextColor} forState:UIControlStateNormal];
    
    [filterControl setSelectedSegmentIndex:1];
    filterControl.frame = [self getControlRectForOffset:offset];
    [self.view addSubview:filterControl];
    [_searchControls setObject:filterControl forKey:kSearchControlFilterControl];
    
    offset += controlSectionHeight;
    
    UILabel *distanceLabel = [ClimbersBuddyStyle getLabelWithSearchFormatting];
    distanceLabel.frame = [self getLabelRectForOffset:offset];
    [distanceLabel setText:@"Max miles from location:"];
    [self.view addSubview:distanceLabel];
    
    NSMutableArray *distanceStrings = [NSMutableArray arrayWithCapacity:3];
    NSArray *miles = [ClimbersBuddyStyle getMiles];
    for(NSNumber *number in miles){
        if (number == [miles lastObject]) {
            break;
        }
        [distanceStrings addObject:[number description]];
    }
    [distanceStrings addObject:[NSString stringWithFormat:@"%@+",[miles lastObject]]];
    NSArray *distanceItems = distanceStrings;
    UISegmentedControl *distanceControl = [ClimbersBuddyStyle getSegmentedControlWithItems:distanceItems withToggle:YES];
    [distanceControl setTitleTextAttributes:@{UITextAttributeTextColor : segmentTextColor} forState:UIControlStateNormal];
    distanceControl.frame = [self getControlRectForOffset:offset];
    [self.view addSubview:distanceControl];
    [_searchControls setObject:distanceControl forKey:kSearchControlDistanceControl];
    
    offset += controlSectionHeight;
    
    UILabel *typeLabel = [ClimbersBuddyStyle getLabelWithSearchFormatting];
    typeLabel.frame = [self getLabelRectForOffset:offset];
    [typeLabel setText:@"Climb type:"];
    [self.view addSubview:typeLabel];
    
    NSArray *typeItems = @[@"Boulder",@"Top Rope",@"Lead",@"Trad."];
    UISegmentedControl *typeControl = [ClimbersBuddyStyle getSegmentedControlWithItems:typeItems withToggle:NO];
    [typeControl setTitleTextAttributes:@{UITextAttributeTextColor : segmentTextColor} forState:UIControlStateNormal];
    typeControl.frame = [self getControlRectForOffset:offset];
    [typeControl setSelectedSegmentIndex:0];
    [typeControl addTarget:self action:@selector(typeChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:typeControl];
    [_searchControls setObject:typeControl forKey:kSearchControlTypeControl];
    

    offset += controlSectionHeight;
    
    UILabel *minDifficultyHolder = [ClimbersBuddyStyle getLabelWithSearchFormatting];
    minDifficultyHolder.frame = [self getLabelRectForOffset:offset];
    [minDifficultyHolder setText:@"Min difficulty:"];
    [self.view addSubview:minDifficultyHolder];
    
    _minDifficultyLabel = [ClimbersBuddyStyle getLabelWithSearchFormatting];
    CGRect minRect = [self getLabelRectForOffset:offset];
    minRect.origin.x += self.view.frame.size.width/4;
    _minDifficultyLabel.frame = minRect;
    [self.view addSubview:_minDifficultyLabel];
    
    UILabel *maxDifficultyHolder = [ClimbersBuddyStyle getLabelWithSearchFormatting];
    CGRect maxDifficultyHolderRect = [self getLabelRectForOffset:offset];
    maxDifficultyHolderRect.origin.x += self.view.frame.size.width/2 - CONTROL_HORIZONTAL_PADDING;
    maxDifficultyHolder.frame = maxDifficultyHolderRect;
    [maxDifficultyHolder setText:@"Max difficulty:"];
    [self.view addSubview:maxDifficultyHolder];
    
    _maxDifficultyLabel = [ClimbersBuddyStyle getLabelWithSearchFormatting];
    CGRect maxRect = [self getLabelRectForOffset:offset];
    maxRect.origin.x += self.view.frame.size.width*3/4 - CONTROL_HORIZONTAL_PADDING;
    _maxDifficultyLabel.frame = maxRect;
    [self.view addSubview:_maxDifficultyLabel];
    
    CGRect rangeSliderRect = [self getControlRectForOffset:offset];
    RangeSlider *difficultySlider = [ClimbersBuddyStyle getRangeSlider:rangeSliderRect];
    [difficultySlider addTarget:self action:@selector(difficultySliderChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:difficultySlider];
    [_searchControls setObject:difficultySlider forKey:kSearchControlDifficultySlider];
    [self typeChanged:typeControl];
    
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
