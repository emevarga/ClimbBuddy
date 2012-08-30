//
//  ClimbInfoTableViewController.h
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/29/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClimbInfoTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_climbs;
    UITableView *_tableView;
}

-(id)initWithClimbs:(NSArray *)climbs;

@end
