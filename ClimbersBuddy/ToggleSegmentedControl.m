//
//  ToggleSegmentedControl.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/27/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "ToggleSegmentedControl.h"

@implementation ToggleSegmentedControl

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSUInteger previousIndex = self.selectedSegmentIndex;
    [super touchesBegan:touches withEvent:event];
    if(self.selectedSegmentIndex == previousIndex){
        [super setSelectedSegmentIndex:UISegmentedControlNoSegment];
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

@end
