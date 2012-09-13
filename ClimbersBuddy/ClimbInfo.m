//
//  ClimbInfo.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 9/11/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "ClimbInfo.h"


@implementation ClimbInfo

@dynamic climbDescription;
@dynamic difficulty;
@dynamic imageName;
@dynamic latitude;
@dynamic locationName;
@dynamic longitude;
@dynamic name;
@dynamic wallName;
@dynamic type;

const NSString *kClimbNameKey = @"climb name";
const NSString *kClimbTypeKey = @"climb type";
const NSString *kDifficultyKey = @"difficulty";
const NSString *kWallNameKey = @"route name";
const NSString *kLocationKey = @"location";
const NSString *kCoordinateKey = @"coordinate";
const NSString *kLatitudeKey = @"latitude";
const NSString *kLongitudeKey = @"longitude";
const NSString *kImageNameKey = @"image name";
const NSString *kDescriptionKey = @"description";

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

static NSString *noImage = @"nopic.png";


-(void)setValuesFor:(NSDictionary *)climbData{
    self.name = [climbData objectForKey:kClimbNameKey];
    self.type = [climbData objectForKey:kClimbTypeKey];
    self.difficulty = [climbData objectForKey:kDifficultyKey];
    self.wallName = [climbData objectForKey:kWallNameKey];
    self.locationName = [climbData objectForKey:kLocationKey];
    self.latitude = [climbData objectForKey:kLatitudeKey];
    self.longitude = [climbData objectForKey:kLongitudeKey];
    self.imageName = [climbData objectForKey:kImageNameKey];
    if(!self.imageName){
        self.imageName = noImage;
    }
    self.climbDescription = [climbData objectForKey:kDescriptionKey];
}

@end
