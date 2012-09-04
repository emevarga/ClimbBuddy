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
extern const NSString *kLocationKey;
extern const NSString *kCoordinateKey;
extern const NSString *kImageNameKey;
extern const NSString *kDescriptionKey;

@interface ClimbInfo : NSObject{
    NSString *_name;
    ClimbType _type;
    NSUInteger _difficulty;
    NSString *_wallName;
    NSString *_locationName;
    CLLocationCoordinate2D _coordinate;
    const NSString *_imageName;
    NSString *_description;
}

@property(readonly)NSString *name;
@property(readonly)ClimbType type;
@property(readonly)NSUInteger difficulty;
@property(readonly)NSString *wallName;
@property(readonly)NSString *locationName;
@property(readonly)CLLocationCoordinate2D coordinate;
@property(readonly)NSString *imageName;
@property(readonly)NSString *description;


+(NSArray *)getRopedDifficulties;
+(NSArray *)getBoulderDifficulties;

-(id)initWithDictionary:(NSDictionary *)climbData;

@end
