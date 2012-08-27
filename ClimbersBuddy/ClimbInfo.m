//
//  ClimbInfo.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/24/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "ClimbInfo.h"

@implementation ClimbInfo

static NSArray *__ropedDifficulties = nil;
static NSArray *__boulderDifficulties = nil;


+(NSArray *)getRopedDifficulties{
    if(!__ropedDifficulties){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            __ropedDifficulties = [[NSArray alloc] initWithObjects:@"5.0",@"5.1",@"5.2",@"5.3",@"5.4",@"5.5",@"5.6",@"5.7-",@"5.7+",@"5.8-",@"5.8+",@"5.9-",@"5.9+",@"5.10a",@"5.10b",@"5.10c",@"5.10d",@"5.11a",@"5.11b",@"5.11c",@"5.11d",@"5.12a",@"5.12b",@"5.12c",@"5.12d",@"5.13a",@"5.13b",@"5.13c",@"5.13d",@"5.14a",@"5.14b",@"5.14c",@"5.14d",@"5.15a",@"5.15b",@"5.15c",nil];
        });
    }
    return [NSArray arrayWithArray:__ropedDifficulties];
}
+(NSArray *)getBoulderDifficulties{
    if(!__boulderDifficulties){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            __boulderDifficulties = [[NSArray alloc] initWithObjects:@"V0",@"V1",@"V2",@"V3",@"V4",@"V5",@"V6",@"V7",@"V8",@"V9",@"V10",@"V11",@"V12",@"V13",@"V14",@"V15",@"V16", nil];
        });
    }
    return [NSArray arrayWithArray:__boulderDifficulties];
}


@end
