//
//  SearchResultClimbDetailViewController.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 9/17/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "SearchResultClimbDetailViewController.h"
#import "MyClimbsManager.h"
@interface SearchResultClimbDetailViewController ()

@end

@implementation SearchResultClimbDetailViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if([MyClimbsManager myClimbsContains:_climb]){
        _addButton.enabled = NO;
    }
}

-(void)loadView{
    [super loadView];
    CGRect buttonFrame = _directionsButton.frame;
    _addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonFrame.origin.y += buttonFrame.size.height + 10;
    _addButton.frame = buttonFrame;
    [_addButton setTitle:@"Add to MyClimbs" forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(saveClimb) forControlEvents:UIControlEventTouchUpInside];
    if([MyClimbsManager myClimbsContains:_climb]){
        _addButton.enabled = NO;
    }
    [self.view addSubview:_addButton];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
