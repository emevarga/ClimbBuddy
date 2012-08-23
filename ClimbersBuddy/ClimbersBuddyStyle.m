//
//  ClimbersBuddyStyle.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/23/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "ClimbersBuddyStyle.h"

@implementation ClimbersBuddyStyle

+(UILabel *)getLabelWithSearchFormatting{
    UILabel *searchLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    UIFont *searchFont = [UIFont boldSystemFontOfSize:11];
    [searchLabel setFont:searchFont];
    [searchLabel setTextColor:[UIColor darkGrayColor]];
    return searchLabel;
}

@end
