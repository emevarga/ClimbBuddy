//
//  ClimbInfo.h
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/24/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    roped = 10,
    boulder = 11
}ClimbType;

@interface ClimbInfo : NSObject{
    @private
    NSArray *_ropedDifficulties;
    NSArray *_boulderDifficulties;
}

+(NSArray *)getRopedDifficulties;
+(NSArray *)getBoulderDifficulties;


@end
