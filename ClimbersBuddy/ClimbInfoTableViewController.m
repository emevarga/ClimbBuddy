//
//  ClimbInfoTableViewController.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/29/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "ClimbInfoTableViewController.h"
#import "ClimbInfo.h"

@interface ClimbInfoTableViewController ()

@end

@implementation ClimbInfoTableViewController

-(id)initWithClimbs:(NSArray *)climbs{
    self = [super init];
    if(self){
        _climbs = [NSMutableArray arrayWithArray:climbs];
    }
    return self;
}

-(void)loadView{
    [super loadView];
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    _tableView.frame = self.view.frame;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Table View Data Source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return [_climbs count];
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"climbcell";
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    ClimbInfo *climb = [_climbs objectAtIndex:indexPath.row];
    [cell.textLabel setText:climb.name];
    [cell.detailTextLabel setText:climb.areaName];
    
    return cell;
}

#pragma mark Table View Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //push view controller for climb
}











@end
