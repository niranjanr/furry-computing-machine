//
//  WhereamiViewController.m
//  Whereami
//
//  Created by Niranjan Ravichandran on 10/6/13.
//  Copyright (c) 2013 Niranjan Ravichandran. All rights reserved.
//

#import "WhereamiViewController.h"

@interface WhereamiViewController ()

@end

@implementation WhereamiViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.delegate = self;
        [self.locationManager startUpdatingLocation];
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"%@", newLocation);
}

- (void)dealloc {
    self.locationManager.delegate = nil;
    self.locationManager = nil;
}

@end
