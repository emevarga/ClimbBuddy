//
//  SearchResultViewController.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/30/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "SearchResultViewController.h"
#import "SearchResultClimbDetailViewController.h"
#import "ClimbInfo.h"
#import "CommonDefines.h"
#import "SearchFilter.h"
#import "ClimbParser.h"

@interface SearchResultViewController ()
-(void)fetchJSON;
@end

@implementation SearchResultViewController

-(id)initWithSearchFilter:(SearchFilter *)filter{
    self = [super init];
    if(self){
        self.title = @"Results";
        _climbs = [NSMutableArray arrayWithCapacity:10];
        _requestSent = NO;
        _searchFilter = filter;
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(!_requestSent){
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [self fetchJSON];
    }else{
        NSIndexPath *selectedIndex = [_tableView indexPathForSelectedRow];
        if(selectedIndex){
            [_tableView deselectRowAtIndexPath:selectedIndex animated:YES];
        }
    }
}

-(void)fetchJSON{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[_searchFilter urlForFilters]]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               NSString *json = [NSString stringWithUTF8String:[data bytes]];
                               NSArray *climbs = [ClimbParser getClimbsFor:json];
                               _climbs = [NSMutableArray arrayWithArray:climbs];
                              _requestSent = YES;
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                   [_tableView reloadData];
                               });
                               
                           }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(!_requestSent){
        return 1;
    }else{
        return [super tableView:tableView numberOfRowsInSection:section];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!_requestSent){
        static NSString *loadingID = @"loading";
        UITableViewCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:loadingID];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loadingID];
        }
        cell.textLabel.backgroundColor = BACKGROUND_COLOR;
        cell.detailTextLabel.backgroundColor = BACKGROUND_COLOR;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.contentView.backgroundColor = BACKGROUND_COLOR;
        
        [cell.textLabel setText:@"Loading..."];
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!_requestSent){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }else{
        ClimbInfo *climb = [_climbs objectAtIndex:indexPath.row];
        ClimbDetailViewController *detail = [[SearchResultClimbDetailViewController alloc] initWithClimb:climb];
        [self.navigationController pushViewController:detail animated:YES];
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
