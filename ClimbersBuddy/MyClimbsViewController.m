//
//  MyClimbsViewController.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/21/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "MyClimbsViewController.h"
#import "MyClimbsManager.h"

@interface MyClimbsViewController ()

@end

@implementation MyClimbsViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _climbs = [NSMutableArray arrayWithArray:[MyClimbsManager myClimbs]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
