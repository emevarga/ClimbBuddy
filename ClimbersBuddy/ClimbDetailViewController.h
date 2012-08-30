//
//  ClimbDetailViewController.h
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/30/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ClimbInfo;

@interface ClimbDetailViewController : UIViewController{
    ClimbInfo *_climb;
}

-(id)initWithClimb:(ClimbInfo *)climb;

@end
