//
//  SearchResultViewController.h
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/30/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "ClimbInfoTableViewController.h"

@class SearchFilter;

@interface SearchResultViewController : ClimbInfoTableViewController{
    BOOL _requestSent;
    SearchFilter *_searchFilter;
}
-(id)initWithSearchFilter:(SearchFilter *)filter;

@end
