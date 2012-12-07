//
//  ExpandableView.m
//  ClimbBuddy
//
//  Created by Clark Barry on 12/7/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "ExpandableView.h"

@implementation ExpandableView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.expanded = NO;
        self.originalFrame = frame;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
