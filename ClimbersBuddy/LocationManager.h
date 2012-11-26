//
//  LocationManager.h
//  ClimbBuddy
//
//  Created by Clark Barry on 11/26/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject<CLLocationManagerDelegate>{
    CLLocationManager *_manager;
    CLLocation *_location;
}

+(LocationManager *)getInstance;
-(CLLocation *)getLocation;
-(void)start;
-(void)stop;

@end
