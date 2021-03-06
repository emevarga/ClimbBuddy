//
//  ClimbersBuddyStyle.h
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/23/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "ClimbInfo.h"
@class RangeSlider;


@interface ClimbersBuddyStyle : NSObject

+(UILabel *)getLabelWithSearchFormatting;
+(UILabel *)getClimbDetailLabel;
+(NSString *)getFillerDescriptionText;

+(NSString *)getStringForTypeEnum:(ClimbType)type;
+(ClimbType)getEnumForString:(NSString *)string;
+(ClimbType)getTypeForIndex:(NSUInteger)index;


+(NSArray *)getMiles;
+(NSInteger)milesForSegment:(NSUInteger)index;
+(UIButton *)getButtonForSearch;
+(RangeSlider *)getRangeSlider:(CGRect)rect;
+(UISegmentedControl *)getSegmentedControlWithItems:(NSArray *)items withToggle:(BOOL)toggle;
+(CALayer *)getGradientForLayer:(CALayer *)layer;

+(NSString *)directionsURLForStart:(CLLocationCoordinate2D)start toFinish:(CLLocationCoordinate2D)finish withWalking:(BOOL)walking;

@end
