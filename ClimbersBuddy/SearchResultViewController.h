//
//  SearchResultViewController.h
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/30/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "ClimbInfoTableViewController.h"

@class SearchFilter;

@interface SearchResultViewController : ClimbInfoTableViewController<UIAlertViewDelegate>{
    BOOL _requestSent;
    BOOL _shouldTryAgain;
    SearchFilter *_searchFilter;
}
-(id)initWithSearchFilter:(SearchFilter *)filter;

@end
