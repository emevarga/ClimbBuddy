//
//  ClimbInfo.h
//  ClimbersBuddy
//
//  Created by Clark Barry on 9/11/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

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
extern const NSString *kLatitudeKey;
extern const NSString *kLongitudeKey;
extern const NSString *kImageNameKey;
extern const NSString *kDescriptionKey;


@interface ClimbInfo : NSManagedObject

@property (nonatomic, retain) NSString * climbDescription;
@property (nonatomic, retain) NSString * difficulty;
@property (nonatomic, retain) NSString * imageName;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSString * locationName;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * wallName;
@property (nonatomic, retain) NSNumber * type;

+(NSArray *)getRopedDifficulties;
+(NSArray *)getBoulderDifficulties;

-(void)setValuesFor:(NSDictionary *)climbData;

@end
