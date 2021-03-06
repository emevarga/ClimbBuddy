//
//  ClimbInfoTableViewController.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/29/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "ClimbInfoTableViewController.h"
#import "ClimbInfo.h"
#import "ClimbDetailViewController.h"
#import "CommonDefines.h"

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
    self.view.backgroundColor = BACKGROUND_COLOR;
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = BACKGROUND_COLOR;
    [self.view addSubview:_tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    [_tableView reloadData];
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
    [cell.textLabel setText:[NSString stringWithFormat:@"%@, %@",climb.wallName,climb.locationName]];
    [cell.textLabel setBackgroundColor:BACKGROUND_COLOR];
    [cell.detailTextLabel setText:climb.name];
    cell.detailTextLabel.backgroundColor = BACKGROUND_COLOR;
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.contentView.backgroundColor = BACKGROUND_COLOR;
    return cell;
}

#pragma mark Table View Delegate












@end
