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
    NSInteger _maxDistance;
    NSString *_filterType;
}

@property(readonly)NSString * type;
@property(readonly)NSUInteger minDifficulty;
@property(readonly)NSUInteger maxDifficulty;
@property(readonly)NSInteger maxDistance;

-(id)initFor:(NSString *)type withMinDifficulty:(NSUInteger)minDifficulty maxDifficulty:(NSUInteger)maxDifficulty maxDistance:(NSInteger)maxDistance filterType:(NSString *)filterType;
-(NSString *)urlForFilters;

@end
