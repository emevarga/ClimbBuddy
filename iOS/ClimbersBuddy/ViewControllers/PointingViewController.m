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
#import "ClimbersBuddyStyle.h"

@interface PointingViewController ()
-(NSArray *)getConstraints;
@end

@implementation PointingViewController

-(id)initWithTargetLocationCoordinate:(CLLocationCoordinate2D)targetCoordinate{
    self = [super init];
    if(self){
        _manager = [[CLLocationManager alloc] init];
        _manager.delegate = self;
        [_manager setDesiredAccuracy:kCLLocationAccuracyBest];
        [_manager setDistanceFilter:kCLDistanceFilterNone];
        _target = [[CLLocation alloc] initWithLatitude:targetCoordinate.latitude longitude:targetCoordinate.longitude];
    }
    return self;
}

-(void)loadView{
    [super loadView];
    
    [self.view setBackgroundColor:BACKGROUND_COLOR];
    
    _compass = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"compass.png"]];
    [_compass setContentMode:UIViewContentModeScaleAspectFit];
    [_compass setSize:CGSizeMake(self.view.frame.size.width*3./4., self.view.frame.size.height*3./4.)];
    
    [self.view addSubview:_compass];
    
    _distanceLabel = [ClimbersBuddyStyle getClimbDetailLabel];
    [_distanceLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_distanceLabel setTextAlignment:NSTextAlignmentCenter];
    [_distanceLabel setText:@"Hi!"];
    [self.view addSubview:_distanceLabel];
    
    [self.view addConstraints:[self getConstraints]];
    
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
    CLLocationDistance meters = [_target distanceFromLocation:newLocation];
    if(meters > 1000){
        CLLocationDistance km = meters/1000;
        [_distanceLabel setText:[NSString stringWithFormat:@"%f km",km]];
    }else{
        [_distanceLabel setText:[NSString stringWithFormat:@"%f m",meters]];
    }
}

- (float) getHeadingForDirectionFromCoordinate:(CLLocationCoordinate2D)fromLoc toCoordinate:(CLLocationCoordinate2D)toLoc{
    float fLat = fromLoc.latitude/180.0*M_PI;
    float fLng = fromLoc.longitude/180.0*M_PI;
    float tLat = toLoc.latitude/180.0*M_PI;
    float tLng = toLoc.longitude/180.0*M_PI;
    
    return atan2(sin(tLng-fLng)*cos(tLat), cos(fLat)*sin(tLat)-sin(fLat)*cos(tLat)*cos(tLng-fLng));
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    float heading =  -newHeading.trueHeading * M_PI / 180.0f;
    float bearing = [self getHeadingForDirectionFromCoordinate:([[_manager location] coordinate]) toCoordinate:[_target coordinate]];
    float newRad = bearing = heading;
    [UIView animateWithDuration:.3
                     animations:^{
                         _compass.transform = CGAffineTransformMakeRotation(newRad);
                     }];
}

-(NSArray *)getConstraints{
    NSMutableArray *constraints = [[NSMutableArray alloc] init];

    NSLayoutConstraint *labelTop = [NSLayoutConstraint constraintWithItem:_distanceLabel
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.view
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1.0
                                                                 constant:10];
    [constraints addObject:labelTop];
    
    NSLayoutConstraint *labelCenter = [NSLayoutConstraint constraintWithItem:_distanceLabel
                                                                     attribute:NSLayoutAttributeCenterX
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.view
                                                                     attribute:NSLayoutAttributeCenterX
                                                                    multiplier:1.0
                                                                      constant:-10];
    [constraints addObject:labelCenter];
    
    return constraints;

}


@end
