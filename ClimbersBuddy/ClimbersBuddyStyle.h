//
//  ClimbersBuddyStyle.h
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/23/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClimbInfo.h"
@class RangeSlider;

@interface ClimbersBuddyStyle : NSObject

+(UILabel *)getLabelWithSearchFormatting;
+(UILabel *)getClimbDetailLabel;
+(NSString *)getFillerDescriptionText;

+(NSString *)getStringForTypeEnum:(ClimbType)type;
+(ClimbType)getTypeForIndex:(NSUInteger)index;


+(NSArray *)getMiles;
+(NSUInteger)milesForSegment:(NSUInteger)index;
+(UIButton *)getButtonForSearch;
+(RangeSlider *)getRangeSlider:(CGRect)rect;
+(UISegmentedControl *)getSegmentedControlWithItems:(NSArray *)items withToggle:(BOOL)toggle;
+(CALayer *)getGradientForLayer:(CALayer *)layer;

@end
