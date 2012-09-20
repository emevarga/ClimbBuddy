//
//  SearchResultViewController.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/30/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "SearchResultViewController.h"
#import "SearchResultClimbDetailViewController.h"

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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ClimbInfo *climb = [_climbs objectAtIndex:indexPath.row];
    ClimbDetailViewController *detail = [[SearchResultClimbDetailViewController alloc] initWithClimb:climb];
    [self.navigationController pushViewController:detail animated:YES];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
