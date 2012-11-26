//
//  LocationManager.m
//  ClimbBuddy
//
//  Created by Clark Barry on 11/26/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>
static LocationManager *__locationManager;

@implementation LocationManager

+(LocationManager *)getInstance{
    if(!__locationManager){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            __locationManager = [[LocationManager alloc] init];
        });
    }
    return __locationManager;
}


-(id)init{
    self = [super init];
    if(self){
        _manager = [[CLLocationManager alloc] init];
        _manager.delegate = self;
    }
    return self;
}

-(void)start{
    [_manager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    _location = [locations lastObject];
}

-(CLLocation *)getLocation{
    return [[CLLocation alloc] initWithLatitude:_location.coordinate.latitude longitude:_location.coordinate.longitude];
}

-(void)stop{
    [_manager stopUpdatingLocation];
}

@end
