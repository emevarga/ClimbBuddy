//
//  BorderLayer.h
//  ClimbersBuddy
//
//  Created by Clark Barry on 9/18/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface LineLayer : CALayer{
    CGPoint _startPoint;
    CGPoint _endPoint;
    CGFloat _width;
    CGColorRef _color;
}

-(id)initWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint width:(CGFloat)width andColor:(CGColorRef)color;
@end
