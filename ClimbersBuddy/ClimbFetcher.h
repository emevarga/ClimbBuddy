//
//  ClimbFetcher.h
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/30/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SearchFilter;

@interface ClimbFetcher : NSObject

+(NSArray *)getClimbsFor:(SearchFilter *)filter;

@end
