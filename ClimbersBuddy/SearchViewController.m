//
//  SearchViewController.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/21/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "SearchViewController.h"

#import "CommonDefines.h"


const NSString *kSearchControlAreaField = @"area field";
const NSString *kSearchControlDistanceControl = @"distance";
const NSString *kSearchControlTypeControl = @"type";
const NSString *kSearchControlDifficultySlider = @"difficulty";
const NSString *kSearchControlHeightSlider = @"height";
const NSString *kSearchControlSearchButton = @"search button";
const NSString *kSearchControlDifficultyLabel = @"difficulty label";

@interface SearchViewController (Internal)

@end

@implementation SearchViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"Search";
    }
    return self;
}

-(void)loadView{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    if(!_searchControls){
        _searchControls = [[NSMutableDictionary alloc]initWithCapacity:5];
    }
    
/*    UITextField *areaField = [[UITextField alloc]initWithFrame:CGRectMake(SEARCH_CONTROL_PADDING,SEARCH_CONTROL_PADDING, 240, SEARCH_CONTROL_HEIGHT)];
    areaField.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin);
    areaField.borderStyle = UITextBorderStyleRoundedRect;
    areaField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    areaField.placeholder = @"Area";
    [self.view addSubview:areaField];
    [_searchControls setObject:areaField forKey:kSearchControlAreaField];*/
  
    UILabel *filterLabel = [[UILabel alloc]initWithFrame:CGRectMake(SEARCH_CONTROL_PADDING, SEARCH_CONTROL_PADDING, 240, SEARCH_CONTROL_HEIGHT/4)];
    [filterLabel setText:@"Distance from location"];
    [self.view addSubview:filterLabel];
    [_searchControls setObject:filterLabel forKey:@"filter label"];
    
    NSArray *distanceItems = @[@"20 miles",@"50 miles",@"100 miles",@"500 miles"];
    UISegmentedControl *distanceControl = [[UISegmentedControl alloc]initWithItems:distanceItems];
    distanceControl.frame = CGRectMake(SEARCH_CONTROL_PADDING, SEARCH_CONTROL_PADDING*2+SEARCH_CONTROL_HEIGHT, 240, SEARCH_CONTROL_HEIGHT);
    [distanceControl setTitleTextAttributes:@{ UITextAttributeFont : [UIFont systemFontOfSize:12] } forState:UIControlStateNormal];
    [self.view addSubview:distanceControl];
    [_searchControls setObject:distanceControl forKey:kSearchControlDistanceControl];
    
    NSArray *typeItems = @[@"Roped",@"Boulder"];
    UISegmentedControl *typeControl = [[UISegmentedControl alloc]initWithItems:typeItems];
    [typeControl setTitleTextAttributes:@{ UITextAttributeFont : [UIFont systemFontOfSize:12] } forState:UIControlStateNormal];
    typeControl.frame = CGRectMake(SEARCH_CONTROL_PADDING, SEARCH_CONTROL_PADDING*3+SEARCH_CONTROL_HEIGHT*2, 240, SEARCH_CONTROL_HEIGHT);
    [self.view addSubview:typeControl];
    [_searchControls setObject:typeItems forKey:kSearchControlTypeControl];
    
    UILabel *difficultyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SEARCH_CONTROL_PADDING, SEARCH_CONTROL_HEIGHT*[_searchControls count]+SEARCH_CONTROL_PADDING*([_searchControls count]+1), 240, SEARCH_CONTROL_HEIGHT)];
    [difficultyLabel setText:@"Max Difficulty"];
    [self.view addSubview:difficultyLabel];
    [_searchControls setObject:difficultyLabel forKey:kSearchControlDifficultyLabel];
    
    UISlider *difficultySlider = [[UISlider alloc]initWithFrame:CGRectMake(SEARCH_CONTROL_PADDING, SEARCH_CONTROL_HEIGHT*[_searchControls count]+SEARCH_CONTROL_PADDING*([_searchControls count]+1), 240, SEARCH_CONTROL_HEIGHT)];
    [self.view addSubview:difficultySlider];
    [_searchControls setObject:difficultySlider forKey:kSearchControlDifficultySlider];
    
    UISlider *heightSlider = [[UISlider alloc]initWithFrame:CGRectMake(SEARCH_CONTROL_WIDTH, SEARCH_CONTROL_HEIGHT*[_searchControls count]+SEARCH_CONTROL_PADDING*([_searchControls count]+1), SEARCH_CONTROL_WIDTH, SEARCH_CONTROL_HEIGHT)];
    heightSlider.transform = CGAffineTransformMakeRotation(-1*M_PI_2);
    [self.view addSubview:heightSlider];
    [_searchControls setObject:heightSlider forKey:kSearchControlHeightSlider];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [searchButton setTitle:@"Search" forState:UIControlStateNormal];
    searchButton.frame = CGRectMake(SEARCH_CONTROL_PADDING, SEARCH_CONTROL_HEIGHT*[_searchControls count]+SEARCH_CONTROL_PADDING*([_searchControls count]+1), 320-(SEARCH_CONTROL_PADDING*2), SEARCH_CONTROL_HEIGHT*2);
    [self.view addSubview:searchButton];
    [_searchControls setObject:searchButton forKey:kSearchControlSearchButton];

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
