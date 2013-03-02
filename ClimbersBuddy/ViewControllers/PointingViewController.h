//
//  PointingViewController.h
//  ClimbBuddy
//
//  Created by Clark Barry on 3/2/13.
//  Copyright (c) 2013 CSHaus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface PointingViewController : UIViewController<CLLocationManagerDelegate>{
    CLLocationManager *_manager;
    CLLocation *_target;
    UIImageView *_compass;
    UILabel *_distanceLabel;
}

-(id)initWithTargetLocationCoordinate:(CLLocationCoordinate2D)targetCoordinate;

@end
