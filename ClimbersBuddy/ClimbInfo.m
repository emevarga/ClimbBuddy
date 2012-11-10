//
//  ClimbInfo.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/24/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "ClimbInfo.h"
#import "CommonDefines.h"
#import <CoreLocation/CoreLocation.h>

@interface ClimbInfo (Persistance)
+(NSString *)getDocumentsDirectory;
-(BOOL)createDataPath;
@end

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

@synthesize name = _name;
@synthesize type = _type;
@synthesize difficulty = _difficulty;
@synthesize wallName = _wallName;
@synthesize locationName = _locationName;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize parkingLatitude = _parkingLatitude;
@synthesize parkingLongitude = _parkingLongitude;
@synthesize imageName = _imageName;
@synthesize description = _description;

NSString *kClimbNameKey = @"rock_name";
NSString *kClimbTypeKey = @"climb_type";
NSString *kDifficultyKey = @"skill_level";
NSString *kWallNameKey = @"route_name";
NSString *kLocationKey = @"location_name";
NSString *kLatitudeKey = @"latitude";
NSString *kLongitudeKey = @"longitude";
NSString *kParkingLatitudeKey = @"asdf";
NSString *kParkingLongitudeKey = @"asdf";
NSString *kImageNameKey = @"image_url";
NSString *kDescriptionKey = @"description";

NSString *placeHolderImageName = @"nopic.png";

-(id)initWithDictionary:(NSDictionary *)climbData{
    self = [super init];
    if(self){
        _name = [climbData objectForKey:kClimbNameKey];
        NSNumber *climbTypeValue = [climbData objectForKey:kClimbTypeKey];
        _type = [climbTypeValue intValue];
        NSNumber *difficultyValue = [climbData objectForKey:kDifficultyKey];
        _difficulty = [difficultyValue integerValue];
        _wallName = [climbData objectForKey:kWallNameKey];
        _locationName = [climbData objectForKey:kLocationKey];
        _latitude = [climbData objectForKey:kLatitudeKey];
        _longitude = [climbData objectForKey:kLongitudeKey];
        _parkingLatitude = [climbData objectForKey:kParkingLatitudeKey];
        _parkingLongitude = [climbData objectForKey:kParkingLongitudeKey];
        _imageName = [climbData objectForKey:kImageNameKey];
        if(!_imageName){
            _imageName = placeHolderImageName;
        }
        _description = [climbData objectForKey:kDescriptionKey];
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:_name forKey:kClimbNameKey];
    [encoder encodeObject:[NSNumber numberWithInt:_type] forKey:kClimbTypeKey];
    [encoder encodeObject:[NSNumber numberWithInt:_difficulty] forKey:kDifficultyKey];
    [encoder encodeObject:_wallName forKey:kWallNameKey];
    [encoder encodeObject:_locationName forKey:kLocationKey];
    [encoder encodeObject:_latitude forKey:kLatitudeKey];
    [encoder encodeObject:_longitude forKey:kLongitudeKey];
    [encoder encodeObject:_imageName forKey:kImageNameKey];
    [encoder encodeObject:_parkingLatitude forKey:kParkingLatitudeKey];
    [encoder encodeObject:_parkingLongitude forKey:kParkingLongitudeKey];
    [encoder encodeObject:_description forKey:kDescriptionKey];
}

-(id)initWithCoder:(NSCoder *)encoder{
    NSMutableDictionary *climbData = [NSMutableDictionary dictionaryWithCapacity:10];
    [climbData setValue:[encoder decodeObjectForKey:kClimbNameKey] forKey:kClimbNameKey];
    [climbData setValue:[encoder decodeObjectForKey:kClimbTypeKey] forKey:kClimbTypeKey];
    [climbData setValue:[encoder decodeObjectForKey:kWallNameKey] forKey:kWallNameKey];
    [climbData setValue:[encoder decodeObjectForKey:kLocationKey] forKey:kLocationKey];
    [climbData setValue:[encoder decodeObjectForKey:kLatitudeKey] forKey:kLatitudeKey];
    [climbData setValue:[encoder decodeObjectForKey:kLongitudeKey] forKey:kLongitudeKey];
    [climbData setValue:[encoder decodeObjectForKey:kImageNameKey] forKey:kImageNameKey];
    [climbData setValue:[encoder decodeObjectForKey:kParkingLatitudeKey] forKey:kParkingLatitudeKey];
    [climbData setValue:[encoder decodeObjectForKey:kParkingLongitudeKey] forKey:kParkingLongitudeKey];
    [climbData setValue:[encoder decodeObjectForKey:kDescriptionKey] forKey:kDescriptionKey];
    return [self initWithDictionary:climbData];
}

@end
