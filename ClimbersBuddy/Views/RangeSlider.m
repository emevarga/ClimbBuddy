//
//  RangeSlider.m
//  RangeSlider
//
//  Created by Clark Barry on 9/22/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "RangeSlider.h"
#import <QuartzCore/QuartzCore.h>

@interface RangeSlider (Internal)
-(CGFloat)getXForValue:(CGFloat)value;
-(CGFloat)getValueForX:(CGFloat)x;
-(CGFloat)distanceFrom:(CGPoint)p1 to:(CGPoint)p2;
@end

@implementation RangeSlider

@synthesize minimumValue = _minimumValue;
@synthesize maximumValue = _maximumValue;
@synthesize selectedMinimumValue = _selectedMinimumValue;
@synthesize selectedMaximumValue = _selectedMaximumValue;
@synthesize padding = _padding;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds = NO;
        
        _gradientOffset = .2;
        
        _thumbColor = [UIColor colorWithRed:.30 green:.30 blue:.30 alpha:1];
        _thumbHighlightColor = [UIColor colorWithRed:.25 green:.25 blue:.25 alpha:1];
        _trackBackgroundColor = [UIColor colorWithWhite:.75 alpha:1];
        _trackHighlightColor = [UIColor colorWithWhite:.2 alpha:1];
        
        _minimumValue = 0;
        _maximumValue = 100;
        
        _padding = 40;
        
        _selectedMinimumValue = 20;
        _selectedMaximumValue = 80;
        
        _cornerRadius = 10;
        
        _thumbRadius = self.frame.size.height/2 - 5;
        
        _minThumbX = [self getXForValue:_selectedMinimumValue] - _thumbRadius;
        _maxThumbX = [self getXForValue:_selectedMaximumValue] + _thumbRadius;
        
        _minThumbOn = NO;
        _maxThumbOn = NO;
    }
    return self;
}


-(void)drawRect:(CGRect)rect{
    //draw track
    rect = self.frame;
    
    _thumbRadius = self.frame.size.height/2 - 5;
    
    CGFloat gradientOffset = .2;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGSize trackSize = CGSizeMake(rect.size.width-_padding*2, rect.size.height/3);
    CGFloat topOfTrack = rect.size.height/3;
    CGRect trackRect = CGRectMake(_padding, topOfTrack-1, trackSize.width, trackSize.height+2);
    
    CGContextSaveGState(context);
    
    CGFloat topTrackColor[4] = {0,0,0,0};
    [_trackBackgroundColor getRed:&topTrackColor[0] green:&topTrackColor[1] blue:&topTrackColor[2] alpha:&topTrackColor[3]];
    UIColor *darkColor = [UIColor colorWithRed:topTrackColor[0]-gradientOffset green:topTrackColor[1]-gradientOffset blue:topTrackColor[2]-gradientOffset alpha:topTrackColor[3]];
    
    NSArray *colors = @[(id)[darkColor CGColor],(id)[_trackBackgroundColor CGColor]];
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(space, ((__bridge CFArrayRef)colors), NULL);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, _padding, topOfTrack);
    CGContextAddLineToPoint(context, _padding + trackSize.width, topOfTrack);
    CGContextMoveToPoint(context, trackRect.origin.x, trackRect.origin.y - _cornerRadius);
    CGContextAddLineToPoint(context, trackRect.origin.x, trackRect.origin.y +trackRect.size.height - _cornerRadius);
    CGContextAddArc(context, trackRect.origin.x + _cornerRadius, trackRect.origin.y + trackRect.size.height - _cornerRadius, _cornerRadius, M_PI, M_PI_2, 1);
    
    CGContextAddLineToPoint(context, trackRect.origin.x + trackRect.size.width - _cornerRadius, trackRect.origin.y + trackRect.size.height);
    CGContextAddArc(context, trackRect.origin.x + trackRect.size.width - _cornerRadius, trackRect.origin.y + trackRect.size.height - _cornerRadius, _cornerRadius, M_PI_2, 0.0f, 1);
    CGContextAddLineToPoint(context, trackRect.origin.x + trackRect.size.width, trackRect.origin.y + _cornerRadius);
    CGContextAddArc(context, trackRect.origin.x + trackRect.size.width - _cornerRadius, trackRect.origin.y + _cornerRadius, _cornerRadius, 0.0f, -M_PI_2, 1);
    CGContextAddLineToPoint(context, trackRect.origin.x + _cornerRadius, trackRect.origin.y);
    CGContextAddArc(context, trackRect.origin.x + _cornerRadius, trackRect.origin.y + _cornerRadius, _cornerRadius, -M_PI_2, M_PI, 1);
    
    CGContextClip(context);
    
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, topOfTrack), CGPointMake(0, topOfTrack + rect.size.height/3), 0);
    
    CGGradientRelease(gradient);
    
    CGContextRestoreGState(context);
    
    CGRect highlightRect = CGRectMake(_minThumbX, trackRect.origin.y, (_maxThumbX - _minThumbX) + 2,trackRect.size.height);
    
    CGFloat topHighlightColor[4] = {0,0,0,0};
    
    [_trackHighlightColor getRed:&topHighlightColor[0] green:&topHighlightColor[1] blue:&topHighlightColor[2] alpha:&topHighlightColor[3]];
    darkColor = [UIColor colorWithRed:topHighlightColor[0]-gradientOffset green:topHighlightColor[1]-gradientOffset blue:topHighlightColor[2]-gradientOffset alpha:topHighlightColor[3]];
    
    colors = @[(id)[darkColor CGColor],(id)[_trackHighlightColor CGColor]];
    gradient = CGGradientCreateWithColors(space, ((__bridge CFArrayRef)colors), NULL);
    
    CGContextSaveGState(context);
    CGContextAddRect(context, highlightRect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, topOfTrack + rect.size.height/3), 0);
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    
    
    //get thumb color
    CGFloat middleY = trackRect.origin.y + trackRect.size.height/2;
    CGFloat thumbColor[4] = {0,0,0,0};
    [_thumbColor getRed:&thumbColor[0] green:&thumbColor[1] blue:&thumbColor[2] alpha:&thumbColor[3]];
    darkColor = [UIColor colorWithRed:thumbColor[0]-_gradientOffset green:thumbColor[1]-_gradientOffset blue:thumbColor[2]-_gradientOffset alpha:thumbColor[3]];
    
    colors = @[(id)[_thumbColor CGColor],(id)[darkColor CGColor]];
    gradient = CGGradientCreateWithColors(space, ((__bridge CFArrayRef)colors), NULL);
    
    
    //set up min thumb
    CGContextSaveGState(context);
    
    CGRect minThumbRect = CGRectMake(_minThumbX - _thumbRadius, middleY - _thumbRadius, _thumbRadius*2, _thumbRadius*2);
    CGContextAddEllipseInRect(context, minThumbRect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, middleY - _thumbRadius), CGPointMake(0,middleY - _thumbRadius + minThumbRect.size.height), 0);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGRect maxThumbRect = CGRectMake(_maxThumbX - _thumbRadius , middleY - _thumbRadius, _thumbRadius*2, _thumbRadius*2);
    CGContextAddEllipseInRect(context, maxThumbRect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, middleY - _thumbRadius), CGPointMake(0,middleY - _thumbRadius + minThumbRect.size.height), 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    //check if thumbs are selected, draw thumgs
}

-(CGFloat)distanceFrom:(CGPoint)p1 to:(CGPoint)p2{
    CGFloat xDist = p1.x - p2.x;
    CGFloat yDist = p1.y - p2.y;
    return sqrt((xDist * xDist) + (yDist * yDist));
}


-(void)layoutSubviews{
    [super layoutSubviews];
    _minThumbX = [self getXForValue:_selectedMinimumValue];
    _maxThumbX = [self getXForValue:_selectedMaximumValue];
    [self setNeedsDisplay];
}

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint point = [touch locationInView:self.superview];
    CGFloat middleY = self.frame.origin.y + self.frame.size.height/2;
    
    CGFloat hitSize = 44;
    
    CGPoint minThumbPoint = CGPointMake(_minThumbX, middleY);
    CGPoint maxThumbPoint = CGPointMake(_maxThumbX, middleY);
    
    CGFloat minThumbDist = [self distanceFrom:minThumbPoint to:point];
    CGFloat maxThumbDist = [self distanceFrom:maxThumbPoint to:point];
    
    if(hitSize > minThumbDist)
        if(minThumbDist < maxThumbDist){
            _minThumbOn = YES;
        }
    if(hitSize > maxThumbDist){
        if(maxThumbDist < minThumbDist){
            _maxThumbOn = YES;
        }
    }
    return YES;
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    if(!_minThumbOn && !_maxThumbOn){
        return YES;
    }
    CGPoint point = [touch locationInView:self];
    if(_minThumbOn){
        _minThumbX = MIN(MAX(point.x, _padding),_maxThumbX - _thumbRadius*2);
        _selectedMinimumValue = [self getValueForX:_minThumbX + _thumbRadius];
    }else if(_maxThumbOn){
        _maxThumbX = MAX(MIN(point.x,self.frame.size.width - _padding),_minThumbX + _thumbRadius*2);
        _selectedMaximumValue = [self getValueForX:_maxThumbX - _thumbRadius];
    }
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    [self setNeedsDisplay];
    
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    _minThumbOn = NO;
    _maxThumbOn = NO;
}



-(CGFloat)getXForValue:(CGFloat)value{
    return ((self.frame.size.width - _padding*2)*(value-_minimumValue)/(_maximumValue-_minimumValue)) + _padding;
}

-(CGFloat)getValueForX:(CGFloat)x{
    CGFloat value = _minimumValue+(x-_padding -_thumbRadius)/(self.frame.size.width-(_padding*2)-_thumbRadius*2)*(_maximumValue-_minimumValue);
    if(value < _minimumValue){
        value = _minimumValue;
    }else if(value > _maximumValue){
        value = _maximumValue;
    }
    return value;
}

-(void)setThumbColor:(UIColor *)color{
    _thumbColor = color;
}

-(void)setThumbHighlightColor:(UIColor *)color{
    _thumbHighlightColor = color;
}

-(void)setTrackBackgroundColor:(UIColor *)color{
    _trackBackgroundColor = color;
}

-(void)setTrackHighlightColor:(UIColor *)color{
    _trackHighlightColor = color;
}

-(void)setMinimumValue:(CGFloat)minimumValue{
    _minimumValue = minimumValue;
    _selectedMinimumValue = [self getValueForX:_minThumbX];
    _selectedMaximumValue = [self getValueForX:_maxThumbX];
    _minThumbX = [self getXForValue:_selectedMinimumValue];
    _maxThumbX = [self getXForValue:_selectedMaximumValue];
    [self setNeedsDisplay];
}

-(void)setMaximumValue:(CGFloat)maximumValue{
    _maximumValue = maximumValue;
    _selectedMinimumValue = [self getValueForX:_minThumbX];
    _selectedMaximumValue = [self getValueForX:_maxThumbX];
    _minThumbX = [self getXForValue:_selectedMinimumValue];
    _maxThumbX = [self getXForValue:_selectedMaximumValue];
    [self setNeedsDisplay];
}

-(void)setSelectedMinimumValue:(CGFloat)selectedMinimumValue{
    if(selectedMinimumValue < _selectedMaximumValue && selectedMinimumValue >= _minimumValue){
        _selectedMinimumValue = selectedMinimumValue;
        _minThumbX = [self getXForValue:_selectedMinimumValue];
        [self setNeedsDisplay];
    }else{
        //don't do this
    }
}

-(void)setSelectedMaximumValue:(CGFloat)selectedMaximumValue{
    if(selectedMaximumValue > _selectedMinimumValue && selectedMaximumValue <= _maximumValue){
        _selectedMaximumValue = selectedMaximumValue;
        _maxThumbX = [self getXForValue:_selectedMaximumValue];
        [self setNeedsDisplay];
    }else{
        //seriously, don't do this.
    }
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    _minThumbX = [self getXForValue:_selectedMinimumValue];
    _maxThumbX = [self getXForValue:_selectedMaximumValue];
}


@end
