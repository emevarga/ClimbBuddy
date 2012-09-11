//
//  ClimbInfo.h
//  ClimbersBuddy
//
//  Created by Clark Barry on 9/11/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>






@interface ClimbInfo : NSManagedObject

@property (nonatomic, retain) NSString * climbDescription;
@property (nonatomic, retain) NSString * difficulty;
@property (nonatomic, retain) NSString * imageName;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSString * locationName;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * routeName;
@property (nonatomic, retain) NSString * type;

@end
