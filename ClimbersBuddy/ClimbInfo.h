//
//  ClimbInfo.h
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/24/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef enum{
    any = 9,
    boulder = 10,
    topRope = 11,
    lead = 12,
    trad = 13,
}ClimbType;

extern const NSString *kClimbNameKey;
extern const NSString *kClimbTypeKey;
extern const NSString *kDifficultyKey;
extern const NSString *kWallNameKey;
extern const NSString *kAreaNameKey;
extern const NSString *kLocationKey;
extern const NSString *kImageNameKey;

@interface ClimbInfo : NSObject{
    NSString *_name;
    ClimbType _type;
    NSUInteger _difficulty;
    NSString *_wallName;
    NSString *_areaName;
    CLLocationCoordinate2D _location;
    const NSString *_imageName;
}

@property(readonly)NSString *name;
@property(readonly)ClimbType type;
@property(readonly)NSUInteger difficulty;
@property(readonly)NSString *wallName;
@property(readonly)NSString *areaName;
@property(readonly)CLLocationCoordinate2D location;
@property(readonly)NSString *imageName;


+(NSArray *)getRopedDifficulties;
+(NSArray *)getBoulderDifficulties;

-(id)initWithDictionary:(NSDictionary *)climbData;

@end
