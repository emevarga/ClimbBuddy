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
    ClimbType _type;
    NSUInteger _maxDifficulty;
    NSUInteger _maxHeight;
    NSUInteger _maxDistance;
}

@property(readonly)ClimbType type;
@property(readonly)NSUInteger maxDifficulty;
@property(readonly)NSUInteger maxHeight;
@property(readonly)NSUInteger maxDistance;

-(id)initFor:(ClimbType)type withMaxDifficulty:(NSUInteger)maxDifficulty maxHeight:(NSUInteger)maxHeight andMaxDistance:(NSUInteger)maxDistance;

@end
