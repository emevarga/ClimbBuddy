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
@synthesize maxHeight = _maxHeight;
@synthesize maxDistance = _maxDistance;

-(id)initFor:(ClimbType)type withMaxDifficulty:(NSUInteger)maxDifficulty maxHeight:(NSUInteger)maxHeight andMaxDistance:(NSUInteger)maxDistance{
    self = [super init];
    if(self){
        _type = type;
        _maxDifficulty = maxDifficulty;
        _maxHeight = maxHeight;
        _maxDistance = maxDistance;
    }
    return self;
}

@end
