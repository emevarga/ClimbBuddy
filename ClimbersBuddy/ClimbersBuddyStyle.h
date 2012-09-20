//
//  ClimbersBuddyStyle.h
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/23/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClimbInfo.h"

@interface ClimbersBuddyStyle : NSObject

+(UILabel *)getLabelWithSearchFormatting;
+(UILabel *)getClimbDetailLabel;
+(NSString *)getFillerDescriptionText;
+(NSString *)getStringForTypeEnum:(ClimbType)type;
+(UIButton *)getButtonForSearch;
+(UISegmentedControl *)getSegmentedControlWithItems:(NSArray *)items;
+(CALayer *)getGradientForLayer:(CALayer *)layer;

@end
