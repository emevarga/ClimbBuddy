//
//  ClimbParser.h
//  ClimbersBuddy
//
//  Created by Clark Barry on 11/6/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClimbParser : NSObject

+(NSArray *)getClimbsFor:(NSString *)jsonString;

@end
