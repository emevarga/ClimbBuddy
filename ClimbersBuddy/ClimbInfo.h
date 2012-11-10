//
//  ClimbInfo.h
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/24/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum{
    any = 9,
    boulder = 10,
    topRope = 11,
    lead = 12,
    trad = 13,
}ClimbType;

extern NSString *kClimbNameKey;
extern NSString *kClimbTypeKey;
extern NSString *kDifficultyKey;
extern NSString *kWallNameKey;
extern NSString *kLocationKey;
extern NSString *kLatitudeKey;
extern NSString *kLongitudeKey;
extern NSString *kParkingLatitudeKey;
extern NSString *kParkingLongitudeKey;
extern NSString *kImageNameKey;
extern NSString *kDescriptionKey;

extern NSString *placeHolderImageName;

@interface ClimbInfo : NSObject<NSCoding>{
    NSString *_name;
    ClimbType _type;
    NSUInteger _difficulty;
    NSString *_wallName;
    NSString *_locationName;
    NSNumber *_latitude;
    NSNumber *_longitude;
    NSNumber *_parkingLatitude;
    NSNumber *_parkingLongitude;
    NSString *_imageName;
    NSString *_description;
}

@property(readonly)NSString *name;
@property(readonly)ClimbType type;
@property(readonly)NSUInteger difficulty;
@property(readonly)NSString *wallName;
@property(readonly)NSString *locationName;
@property(readonly)NSNumber *latitude;
@property(readonly)NSNumber *longitude;
@property(readonly)NSNumber *parkingLatitude;
@property(readonly)NSNumber *parkingLongitude;
@property(readonly)NSString *imageName;
@property(readonly)NSString *description;
@property(readonly)NSString *docPath;


+(NSArray *)getRopedDifficulties;
+(NSArray *)getBoulderDifficulties;

-(id)initWithDictionary:(NSDictionary *)climbData;

@end
