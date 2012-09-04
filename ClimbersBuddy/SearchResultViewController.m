//
//  SearchResultViewController.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/30/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "SearchResultViewController.h"

@interface SearchResultViewController ()

@end

@implementation SearchResultViewController

-(id)initWithClimbs:(NSArray *)climbs{
    self = [super initWithClimbs:climbs];
    if(self){
        self.title = @"Results";
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSIndexPath *selectedIndex = [_tableView indexPathForSelectedRow];
    if(selectedIndex){
        [_tableView deselectRowAtIndexPath:selectedIndex animated:YES];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
