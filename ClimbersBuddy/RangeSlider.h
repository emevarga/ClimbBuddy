//
//  RangeSlider.h
//  RangeSlider
//
//  Created by Clark Barry on 9/22/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RangeSlider : UIControl{
    float _minimumValue;
    float _maximumValue;
    float _selectedMinimumValue;
    float _selectedMaximumValue;

    float _thumbRadius;
    
    float _minThumbX;
    float _maxThumbX;
    
    BOOL _minThumbOn;
    BOOL _maxThumbOn;
    
    UIColor *_thumbColor;
    UIColor *_thumbHighlightColor;
    UIColor *_trackBackgroundColor;
    UIColor *_trackHighlightColor;
    CGFloat _gradientOffset;
}

-(void)setThumbColor:(UIColor *)color;
-(void)setThumbHighlightColor:(UIColor *)color;
-(void)setTrackBackgroundColor:(UIColor *)color;
-(void)setTrackHighlightColor:(UIColor *)color;
-(void)setMinimumValue:(CGFloat)minimumValue;
-(void)setMaximumValue:(CGFloat)maximumValue;

@property(readonly)float minimumValue;
@property(readonly)float maximumValue;
@property(nonatomic)float selectedMinimumValue;
@property(nonatomic)float selectedMaximumValue;

@end
