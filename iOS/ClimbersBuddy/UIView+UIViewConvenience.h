//
//  UIView+UIViewConvenience.h
//  SoundBored
//
//  Created by Clark Barry on 12/1/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIViewConvenience)
-(void)setSize:(CGSize)size;
-(void)setHeight:(CGFloat)height;
-(void)setWidth:(CGFloat)width;
-(void)setOrigin:(CGPoint)point;
-(void)addCornerRadius:(CGFloat)radius;
-(void)addBorderWithColor:(UIColor *)color andRadius:(CGFloat)radius;
-(void)addGradientWithColors:(NSArray *)colors;
-(void)addShadowWithRadius:(CGFloat)radius offset:(CGSize)offset andOpacity:(CGFloat)opacity;
@end
