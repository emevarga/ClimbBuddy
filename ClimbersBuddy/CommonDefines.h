//
//  CommonDefines.h
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/21/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#ifndef ClimbersBuddy_CommonDefines_h
#define ClimbersBuddy_CommonDefines_h

#define CONTROL_HORIZONTAL_PADDING 10
#define CONTROL_VERTICAL_PADDING 8
#define LABEL_HEIGHT 20
#define LABEL_PADDING 2
#define SEARCH_CONTROL_HEIGHT 30

#define SEARCH_CONTROL_WIDTH 300

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

#endif
