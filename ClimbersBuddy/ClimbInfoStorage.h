//
//  ClimbInfoStorage.h
//  ClimbersBuddy
//
//  Created by Clark Barry on 9/11/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import <Foundation/Foundation.h>





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

@end*/

@interface ClimbInfoStorage : NSObject

@end
