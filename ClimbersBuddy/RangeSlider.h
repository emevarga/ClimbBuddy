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
    
    BOOL _minThumbOn;
    BOOL _maxThumbOn;
    
    UIImageView *_minThumb;
    UIImageView *_maxThumb;
    UIImageView *_trackHightlight;
    UIImageView *_trackBackground;
    
    UIColor *_thumbColor;
    UIColor *_thumbHighlightColor;
    UIColor *_trackBackgroundColor;
    UIColor *_trackHighlightColor;
    
}

-(void)setThumbColor:(UIColor *)color;
-(void)setTrackBackgroundColor:(UIColor *)color;
-(void)setTrackHighlightColor:(UIColor *)color;
-(void)setMinimumValue:(CGFloat)minimumValue;
-(void)setMaximumValue:(CGFloat)maximumValue;

@property(readonly)float minimumValue;
@property(readonly)float maximumValue;
@property(nonatomic)float selectedMinimumValue;
@property(nonatomic)float selectedMaximumValue;


@end
