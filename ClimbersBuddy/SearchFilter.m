//
//  SearchFilter.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/25/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "SearchFilter.h"

@implementation SearchFilter

@synthesize type = _type;
@synthesize maxDifficulty = _maxDifficulty;
@synthesize maxDistance = _maxDistance;

-(id)initFor:(NSString *)type withMinDifficulty:(NSUInteger)minDifficulty maxDifficulty:(NSUInteger)maxDifficulty andMaxDistance:(NSUInteger)maxDistance{
    self = [super init];
    if(self){
        _type = type;
        _maxDifficulty = maxDifficulty;
        _minDifficulty = minDifficulty;
        _maxDistance = maxDistance;
    }
    return self;
}

@end
