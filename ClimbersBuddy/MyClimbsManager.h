//
//  MyClimbsManager.h
//  ClimbersBuddy
//
//  Created by Clark Barry on 9/13/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ClimbInfo;

@interface MyClimbsManager : NSObject

+(void)addClimb:(ClimbInfo *)climb;
+(BOOL)myClimbsContains:(ClimbInfo *)climb;
+(NSArray *)myClimbs;

@end
