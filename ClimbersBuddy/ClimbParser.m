//
//  ClimbParser.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 11/6/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "ClimbParser.h"
#import "SBJsonParser.h"
#import "ClimbInfo.h"
#import "ClimbersBuddyStyle.h"
@implementation ClimbParser

+(ClimbInfo *)parseClimb:(NSDictionary *)climbDictionary{
    NSMutableDictionary *climbData = [NSMutableDictionary dictionaryWithCapacity:10];
    
    NSString *typeString = [climbDictionary objectForKey:kClimbTypeKey];
    ClimbType type = [ClimbersBuddyStyle getEnumForString:typeString];
    [climbData setValue:[NSNumber numberWithInt:type] forKey:kClimbTypeKey];
    
    NSString *climbName = [climbDictionary objectForKey:kClimbNameKey];
    [climbData setValue:climbName forKey:kClimbNameKey];
    
    NSString *wallName = [climbDictionary objectForKey:kWallNameKey];
    [climbData setValue:wallName forKey:kWallNameKey];
    
    NSString *areaName = [climbDictionary objectForKey:kLocationKey];
    [climbData setValue:areaName forKey:kLocationKey];
    
    NSNumber *difficulty = [climbDictionary objectForKey:kDifficultyKey];
    [climbData setValue:difficulty forKey:kDifficultyKey];
    
    NSNumber *latitude = [climbDictionary objectForKey:kLatitudeKey];
    [climbData setValue:latitude forKey:kLatitudeKey];
    
    NSNumber *longitude = [climbDictionary objectForKey:kLongitudeKey];
    [climbData setValue:longitude forKey:kLongitudeKey];
    
    NSString *imageURL = [climbDictionary objectForKey:kImageNameKey];
    [climbData setValue:imageURL forKey:kImageNameKey];
    
    NSString *description = [climbDictionary objectForKey:kDescriptionKey];
    [climbData setValue:description forKey:kDescriptionKey];
    
    return [[ClimbInfo alloc] initWithDictionary:climbData];
}

+(NSArray *)getClimbsFor:(NSString *)jsonString{
    NSMutableArray *climbs = [[NSMutableArray alloc] initWithCapacity:10];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSError *error;
    NSArray *jsonClimbs = [parser objectWithString:jsonString error:&error];
    if(error){
        NSLog(@"error = %@",[error localizedDescription]);
        return nil;
    }
    for(NSDictionary *climbDictionary in jsonClimbs){
        ClimbInfo *newClimb = [[self class]parseClimb:climbDictionary];
        if(newClimb){
            [climbs addObject:newClimb];
        }
    }
    
    
    return climbs;
}

@end
