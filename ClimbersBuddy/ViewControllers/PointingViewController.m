//
//  PointingViewController.m
//  ClimbBuddy
//
//  Created by Clark Barry on 3/2/13.
//  Copyright (c) 2013 CSHaus. All rights reserved.
//

#import "PointingViewController.h"
#import "CommonDefines.h"
#import "UIView+UIViewConvenience.h"

@interface PointingViewController ()

@end

@implementation PointingViewController

-(id)init{
    self = [super init];
    if(self){
        _manager = [[CLLocationManager alloc] init];
        _manager.delegate = self;
        [_manager setDesiredAccuracy:kCLLocationAccuracyBest];
        [_manager setDistanceFilter:kCLDistanceFilterNone];
    }
    return self;
}

-(void)loadView{
    [super loadView];
    
    [self.view setBackgroundColor:BACKGROUND_COLOR];
    
    _compass = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"compass.png"]];
    [_compass setContentMode:UIViewContentModeScaleAspectFit];
    [_compass setSize:CGSizeMake(self.view.frame.size.width*5./6., self.view.frame.size.height*5./6.)];
    
    [self.view addSubview:_compass];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_compass setCenter:self.view.center];
    [_manager startUpdatingLocation];
    [_manager startUpdatingHeading];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_manager stopUpdatingLocation];
    [_manager stopUpdatingHeading];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{

}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
	// Convert Degree to Radian and move the needle
	float newRad =  -newHeading.trueHeading * M_PI / 180.0f;
    [UIView animateWithDuration:.3
                     animations:^{
                         _compass.transform = CGAffineTransformMakeRotation(newRad);
                     }];
}


@end
