//
//  ToggleSegmentedControl.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/27/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "ToggleSegmentedControl.h"

@interface ToggleSegmentedControl ()
- (void)_reset;
@end

@implementation ToggleSegmentedControl

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addTarget:self action:@selector(_reset) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

- (id)initWithItems:(NSArray *)items {
    self = [super initWithItems:items];
    if (self) {
        [self addTarget:self action:@selector(_reset) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self setMomentary:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)_reset {
    [self setMomentary:NO];
}

@end
