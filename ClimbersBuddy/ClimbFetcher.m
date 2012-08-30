//
//  ClimbFetcher.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/30/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "ClimbFetcher.h"
#import "SearchFilter.h"
#import "ClimbInfo.h"

@implementation ClimbFetcher

+(NSArray *)getTestClimbs{
    NSMutableArray *climbs = [NSMutableArray arrayWithCapacity:20];
    NSMutableDictionary *climbData = [[NSMutableDictionary alloc] initWithCapacity:5];
    
    for(int i = 50; i <= 51;i++){
        for(int j = 10; j < 12; j++){
            for (int k = 0; k < 2; k++){
                NSString *name = [NSString stringWithFormat:@"Climb: %d",k];
                [climbData setObject:name forKey:kClimbNameKey];
                NSString *wall = [NSString stringWithFormat:@"Wall: %d",j];
                [climbData setObject:wall forKey:kWallNameKey];
                NSString *area = [NSString stringWithFormat:@"Area: %d",i];
                [climbData setObject:area forKey:kAreaNameKey];
                NSNumber *type = [NSNumber numberWithInt:(((i+j+k)%4)+10)];
                [climbData setObject:type forKey:kClimbTypeKey];
                ClimbInfo *climb = [[ClimbInfo alloc] initWithDictionary:climbData];
                [climbs addObject:climb];
                [climbData removeAllObjects];
            }
        }
    }
    
    return climbs;
    
}

+(NSArray *)getClimbsFor:(SearchFilter *)filter{
    NSArray *climbs;
    climbs = [[self class] getTestClimbs];
    NSLog(@"climbs = %@",climbs);
    return climbs;
}

@end
