//
//  BorderLayer.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 9/18/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "LineLayer.h"

@implementation LineLayer

-(id)initWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint width:(CGFloat)width andColor:(CGColorRef)color{
    self = [super init];
    if(self){
        _startPoint = startPoint;
        _endPoint = endPoint;
        _width = width;
        _color = color;
    }
    return self;
}

-(void)drawInContext:(CGContextRef)ctx{
    CGContextSetStrokeColorWithColor(ctx, _color);
    CGContextSetLineWidth(ctx, _width);
    CGContextMoveToPoint(ctx, _startPoint.x, _startPoint.y);
    CGContextAddLineToPoint(ctx, _endPoint.x, _endPoint.y);
    CGContextStrokePath(ctx);
    
}



@end
