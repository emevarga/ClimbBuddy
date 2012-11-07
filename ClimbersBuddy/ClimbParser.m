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

const NSString *kJSONClimbTypeKey = @"climb_type";
const NSString *kJSONClimbNameKey = @"rock_name";
const NSString *kJSONWallNameKey = @"route_name";
const NSString *kJSONLocationKey = @"location_name";
const NSString *kJSONLatitudeKey = @"latitude";
const NSString *kJSONLongitude = @"longitude";
const NSString *kJSONImageKey = @"image_url";
const NSString *kJSONDescriptionKey = @"description";


+(ClimbInfo *)parseClimb:(NSDictionary *)climbDictionary{
    NSMutableDictionary *climbData = [NSMutableDictionary dictionaryWithCapacity:10];
    
    NSString *typeString = [climbDictionary objectForKey:kJSONClimbTypeKey];
    ClimbType type = [ClimbersBuddyStyle getEnumForString:typeString];
    [climbData setValue:[NSNumber numberWithInt:type] forKey:kClimbTypeKey];
    
    NSString *climbName = [climbDictionary objectForKey:kJSONClimbNameKey];
    [climbData setValue:climbName forKey:kClimbNameKey];
    
    NSString *wallName = [climbDictionary objectForKey:kJSONWallNameKey];
    [climbData setValue:wallName forKey:kWallNameKey];
    
    NSString *areaName = [climbDictionary objectForKey:kJSONLocationKey];
    [climbData setValue:areaName forKey:kLocationKey];
    
    NSNumber *latitude = [climbDictionary objectForKey:kJSONLatitudeKey];
    [climbData setValue:latitude forKey:kLatitudeKey];
    
    NSNumber *longitude = [climbDictionary objectForKey:kJSONLongitude];
    [climbData setValue:longitude forKey:kLongitudeKey];
    
    NSString *imageURL = [climbDictionary objectForKey:kJSONImageKey];
    [climbData setValue:imageURL forKey:kImageNameKey];
    
    NSString *description = [climbDictionary objectForKey:kJSONDescriptionKey];
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
