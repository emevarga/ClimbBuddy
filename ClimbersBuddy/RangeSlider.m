//
//  RangeSlider.m
//  RangeSlider
//
//  Created by Clark Barry on 9/22/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "RangeSlider.h"
#import <QuartzCore/QuartzCore.h>

#define PADDING 10

@interface RangeSlider (Internal)
-(void)configureThumbs;
-(UIImage *)getTrackBackgroundForRect:(CGRect)rect;
-(UIImage *)getThumbinRect:(CGRect)rect;
-(UIImage *)getHighlightedThumbInRect:(CGRect)rect;
-(UIImage *)getTrackHighlightForTrackHeight:(CGFloat)height;
-(CGFloat)getXForValue:(CGFloat)value;
-(CGFloat)getValueForX:(CGFloat)x;
-(void)updateHighlight;

@end

@implementation RangeSlider

@synthesize minimumValue = _minimumValue;
@synthesize maximumValue = _maximumValue;
@synthesize selectedMinimumValue = _selectedMinimumValue;
@synthesize selectedMaximumValue = _selectedMaximumValue;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = NO;
        
        _thumbColor = [UIColor colorWithRed:.7 green:.7 blue:.7 alpha:1];
        _thumbHighlightColor = [UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1];
        _trackBackgroundColor = [UIColor colorWithWhite:.75 alpha:1];
        _trackHighlightColor = [UIColor colorWithWhite:.2 alpha:1];

        _trackBackground = [[UIImageView alloc]initWithImage:[self getTrackBackgroundForRect:frame]];
        _trackBackground.layer.masksToBounds = YES;
        _trackBackground.layer.cornerRadius = self.frame.size.height/10;
        [self addSubview:_trackBackground];
        
        _trackHightlight = [[UIImageView alloc]initWithImage:[self getTrackHighlightForTrackHeight:_trackBackground.frame.size.height]];
        [self addSubview:_trackHightlight];
        
        
        _minThumb = [[UIImageView alloc]initWithImage:[self getThumbinRect:self.frame] highlightedImage:[self getHighlightedThumbInRect:self.frame]];
        _minThumb.layer.masksToBounds = NO;
        [self addSubview:_minThumb];
        
        _maxThumb = [[UIImageView alloc]initWithImage:[self getThumbinRect:self.frame] highlightedImage:[self getHighlightedThumbInRect:self.frame]];
        _maxThumb.layer.masksToBounds = NO;
        [self addSubview:_maxThumb];
        
        
        [self configureThumbs];
        [self updateHighlight];
        
        _minThumbOn = NO;
        _maxThumbOn = NO;        
    }
    return self;
}

-(void)configureThumbs{
    _minThumb.contentMode = UIViewContentModeCenter;
    CGPoint center = _minThumb.center;
    _minThumb.frame = CGRectMake(_minThumb.frame.origin.x, _minThumb.frame.origin.y, 44, 44);
    _minThumb.center = center;
    _maxThumb.contentMode = UIViewContentModeCenter;
    center = _maxThumb.center;
    _maxThumb.frame = CGRectMake(_maxThumb.frame.origin.x, _maxThumb.frame.origin.y, 44, 44);
    _maxThumb.center = center;
    
    _trackBackground.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    _trackHightlight.center = _trackBackground.center;
    CGPoint thumbCenter = CGPointMake(_trackBackground.frame.origin.x, self.frame.size.height/2);
    _minThumb.center = thumbCenter;
    thumbCenter.x += _trackBackground.frame.size.width;
    _maxThumb.center = thumbCenter;
}

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint point = [touch locationInView:self];
    if(CGRectContainsPoint(_minThumb.frame, point)){
        _minThumb.highlighted = YES;
        _minThumbOn = YES;
    }else if(CGRectContainsPoint(_maxThumb.frame, point)){
        _maxThumb.highlighted = YES;
        _maxThumbOn = YES;
    }
    return YES;
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    if(!_minThumbOn && !_maxThumbOn){
        return YES;
    }
    CGPoint point = [touch locationInView:self];
    if(_minThumbOn){
        _minThumb.center = CGPointMake(MIN(MAX(point.x, _trackBackground.frame.origin.x),_maxThumb.center.x-(_minThumb.image.size.width/2+_maxThumb.image.size.width/2)), _minThumb.center.y);
        _selectedMinimumValue = [self getValueForX:_minThumb.center.x];
        NSLog(@"New Minimum = %lf",self.selectedMinimumValue);

    }else if(_maxThumbOn){
        _maxThumb.center = CGPointMake(MAX(MIN(point.x,_trackBackground.frame.size.width+_maxThumb.image.size.width/2),_minThumb.center.x+_minThumb.image.size.width/2+_maxThumb.image.size.width/2), _maxThumb.center.y);
        _selectedMaximumValue = [self getValueForX:_maxThumb.center.x];
        NSLog(@"New Maximum = %lf",self.selectedMaximumValue);
    }
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    [self updateHighlight];
    [self setNeedsDisplay];
    
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    if(_minThumb.highlighted){
        _minThumb.highlighted = NO;
    }
    if(_maxThumb.highlighted){
        _maxThumb.highlighted = NO;
    }
    _minThumbOn = NO;
    _maxThumbOn = NO;
}


-(void)updateHighlight{
    _trackHightlight.frame = CGRectMake(_minThumb.center.x, _trackHightlight.frame.origin.y, _maxThumb.center.x-_minThumb.center.x, _trackHightlight.frame.size.height);
}

-(CGFloat)getXForValue:(CGFloat)value{
    return (self.frame.size.width*(value-_minimumValue)/(_maximumValue-_minimumValue));
}

-(CGFloat)getValueForX:(CGFloat)x{
    CGFloat value = _minimumValue+(x-PADDING)/(self.frame.size.width-(PADDING*2))*(_maximumValue-_minimumValue);
    if(value < _minimumValue){
        value = _minimumValue;
    }else if(value > _maximumValue){
        value = _maximumValue;
    }
    return value;
}




-(void)setThumbColor:(UIColor *)color{
    _thumbColor = color;
    _minThumb.image = [self getThumbinRect:self.frame];
    _maxThumb.image = [self getThumbinRect:self.frame];
}

-(void)setTrackBackgroundColor:(UIColor *)color{
    _trackBackgroundColor = color;
    _trackBackground.image = [self getTrackBackgroundForRect:self.frame];
}

-(void)setTrackHighlightColor:(UIColor *)color{
    _trackHighlightColor = color;
    _trackHightlight.image = [self getTrackHighlightForTrackHeight:_trackBackground.image.size.height];
    [self updateHighlight];
}

-(void)setMinimumValue:(CGFloat)minimumValue{
    _minimumValue = minimumValue;
    _selectedMinimumValue = [self getValueForX:_minThumb.center.x];
}

-(void)setMaximumValue:(CGFloat)maximumValue{
    _maximumValue = maximumValue;
    _selectedMaximumValue = [self getValueForX:_maxThumb.center.x];
}

-(void)setSelectedMinimumValue:(CGFloat)selectedMinimumValue{
    if(selectedMinimumValue < _maximumValue && selectedMinimumValue >= _minimumValue){
        _selectedMinimumValue = selectedMinimumValue;
        CGPoint center = _minThumb.center;
        center.x = [self getXForValue:_selectedMinimumValue];
        _minThumb.center = center;
        [self updateHighlight];
    }else{
        //don't do this
    }
}

-(void)setSelectedMaximumValue:(CGFloat)selectedMaximumValue{
    if(selectedMaximumValue > _selectedMinimumValue && selectedMaximumValue <= _maximumValue){
        _selectedMaximumValue = selectedMaximumValue;
        CGPoint center = _maxThumb.center;
        center.x = [self getXForValue:_selectedMaximumValue];
        _maxThumb.center = center;
        [self updateHighlight];
    }else{
        //seriously, don't do this.    
    }

}

-(UIImage *)getThumbinRect:(CGRect)rect{
    UIImage *thumb;
    
    CGSize size = CGSizeMake(rect.size.height*3/4, rect.size.height*3/4);
    
    UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, _thumbColor.CGColor);
    CGRect circleRect = CGRectMake(0, 0, size.width, size.height);
    CGContextFillEllipseInRect(context, circleRect);
    thumb = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return thumb;
}

-(UIImage *)getHighlightedThumbInRect:(CGRect)rect{
    UIImage *thumb;
    CGSize size = CGSizeMake(rect.size.height*3/4, rect.size.height*3/4);

    UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, .5);
    CGContextSetStrokeColorWithColor(context, _thumbHighlightColor.CGColor);
    CGContextSetFillColorWithColor(context, _thumbHighlightColor.CGColor);
    CGRect circleRect = CGRectMake(0, 0, size.width, size.height);
    
    CGContextStrokeEllipseInRect(context, circleRect);
    CGContextFillEllipseInRect(context, circleRect);
    UIGraphicsEndImageContext();
    return thumb;
}

-(UIImage *)getTrackHighlightForTrackHeight:(CGFloat)height{
    UIImage *trackHighlight;

    CGSize size = CGSizeMake(10, height);
    CGFloat gradientOffset = .2;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat topColor[4];
    [_trackHighlightColor getRed:&topColor[0] green:&topColor[1] blue:&topColor[2] alpha:&topColor[3]];
    UIColor *darkColor = [UIColor colorWithRed:topColor[0]-gradientOffset green:topColor[1]-gradientOffset blue:topColor[2]-gradientOffset alpha:topColor[3]];

    NSArray *colors = @[(id)[darkColor CGColor],(id)[_trackHighlightColor CGColor]];
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(space, ((__bridge CFArrayRef)colors), NULL);
    
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, height), 0);
    
    trackHighlight = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return trackHighlight;
}

-(UIImage *)getTrackBackgroundForRect:(CGRect)rect{
    UIImage *track;
    CGFloat gradientOffset = .2;
    
    CGSize size = CGSizeMake(rect.size.width-PADDING*2, rect.size.height/4);
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGContextSetLineWidth(context, 3);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, size.width, 0);
    CGContextStrokePath(context);
    CGContextStrokeRect(context, CGRectMake(0, 0, size.width, size.height));
    
    CGFloat topColor[4];
    [_trackBackgroundColor getRed:&topColor[0] green:&topColor[1] blue:&topColor[2] alpha:&topColor[3]];
    UIColor *darkColor = [UIColor colorWithRed:topColor[0]-gradientOffset green:topColor[1]-gradientOffset blue:topColor[2]-gradientOffset alpha:topColor[3]];
    
    NSArray *colors = @[(id)[darkColor CGColor],(id)[_trackBackgroundColor CGColor]];
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(space, ((__bridge CFArrayRef)colors), NULL);
    
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, rect.size.height/4), 0);
    
    track = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return track;
}

@end
