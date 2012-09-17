//
//  MyClimbsViewController.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/21/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "MyClimbsViewController.h"
#import "MyClimbsManager.h"
#import "MyClimbsDetailViewController.h"

@interface MyClimbsViewController ()

@end

@implementation MyClimbsViewController

-(void)viewWillAppear:(BOOL)animated{
    _climbs = [NSMutableArray arrayWithArray:[MyClimbsManager myClimbs]];
    [super viewWillAppear:animated];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ClimbInfo *climb = [_climbs objectAtIndex:indexPath.row];
    ClimbDetailViewController *detail = [[MyClimbsDetailViewController alloc] initWithClimb:climb];
    [self.navigationController pushViewController:detail animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
