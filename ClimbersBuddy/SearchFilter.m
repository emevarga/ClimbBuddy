//
//  SearchFilter.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/25/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "SearchFilter.h"
#import "CommonDefines.h"
#import <MapKit/MapKit.h>
#import "ClimbersBuddyStyle.h"
#import "LocationManager.h"

@implementation SearchFilter

@synthesize type = _type;
@synthesize maxDifficulty = _maxDifficulty;
@synthesize maxDistance = _maxDistance;

-(id)initFor:(NSString *)type withMinDifficulty:(NSUInteger)minDifficulty maxDifficulty:(NSUInteger)maxDifficulty andMaxDistance:(NSInteger)maxDistance{
    self = [super init];
    if(self){
        _type = type;
        _maxDifficulty = maxDifficulty;
        _minDifficulty = minDifficulty;
        _maxDistance = maxDistance;
    }
    return self;
}

-(NSString *)urlForFilters{
    NSString *maxDistanceString = _maxDistance == -1 ? @"999999999" : [[NSNumber numberWithInteger:_maxDistance] stringValue];
    NSString *minDifficultyString = [[NSNumber numberWithInteger:_minDifficulty] stringValue];
    NSString *maxDifficultyString = [[NSNumber numberWithInteger:_maxDifficulty] stringValue];
    CLLocationCoordinate2D coordinate = [[[LocationManager getInstance] getLocation] coordinate];
    NSString *longitude = [[NSNumber numberWithDouble:coordinate.longitude]stringValue];
    NSString *latitude = [[NSNumber numberWithDouble:coordinate.latitude]stringValue];
    NSString *typeStringForQuery = [_type stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *query = [NSString stringWithFormat:@"%@?lat=%@&lng=%@&dist=%@&min_difficulty=%@&max_difficulty=%@&climb_type=%@",SERVER,latitude,longitude,maxDistanceString,minDifficultyString,maxDifficultyString,typeStringForQuery];
    [[LocationManager getInstance]stop];
    return query;
}

@end
