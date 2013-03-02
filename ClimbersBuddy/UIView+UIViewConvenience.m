//
//  UIView+UIViewConvenience.m
//  SoundBored
//
//  Created by Clark Barry on 12/1/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "UIView+UIViewConvenience.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (UIViewConvenience)

-(void)setSize:(CGSize)size{
    CGRect newFrame = self.frame;
    newFrame.size = size;
    self.frame = newFrame;
}

-(void)setHeight:(CGFloat)height{
    CGRect newFrame = self.frame;
    newFrame.size.height = height;
    self.frame = newFrame;
}

-(void)setWidth:(CGFloat)width{
    CGRect newFrame = self.frame;
    newFrame.size.width = width;
    self.frame = newFrame;

}

-(void)setOrigin:(CGPoint)point{
    CGRect newFrame = self.frame;
    newFrame.origin = point;
    self.frame = newFrame;
}

-(void)addCornerRadius:(CGFloat)radius{
    [self.layer setCornerRadius:radius];
}

-(void)addBorderWithColor:(UIColor *)color andRadius:(CGFloat)radius{
    [self.layer setBorderColor:[color CGColor]];
    [self.layer setBorderWidth:radius];
}

-(void)addGradientWithColors:(NSArray *)colors{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    [gradient setColors:colors];
    [self.layer insertSublayer:gradient atIndex:0];
}

-(void)addShadowWithRadius:(CGFloat)radius offset:(CGSize)offset andOpacity:(CGFloat)opacity{
    self.layer.shadowRadius = radius;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = radius;
}
@end
