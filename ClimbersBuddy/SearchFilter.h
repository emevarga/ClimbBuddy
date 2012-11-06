//
//  SearchFilter.h
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/25/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ClimbInfo.h"

@interface SearchFilter : NSObject{
    NSString *_type;
    NSUInteger _minDifficulty;
    NSUInteger _maxDifficulty;
    NSUInteger _maxDistance;
}

@property(readonly)NSString * type;
@property(readonly)NSUInteger minDifficulty;
@property(readonly)NSUInteger maxDifficulty;
@property(readonly)NSUInteger maxDistance;

-(id)initFor:(NSString *)type withMinDifficulty:(NSUInteger)minDifficulty maxDifficulty:(NSUInteger)maxDifficulty andMaxDistance:(NSUInteger)maxDistance;
-(NSString *)urlForFilters;

@end
