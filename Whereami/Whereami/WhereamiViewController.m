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
        self.locationManager.distanceFilter = 50;
        self.locationManager.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    self.worldView.showsUserLocation = YES;
}

- (void)dealloc {
    self.locationManager.delegate = nil;
    self.locationManager = nil;
}

// location manager delegate methods
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"%@", newLocation);
}

// map view delegate methods
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    CLLocationCoordinate2D loc = userLocation.coordinate;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    self.worldView.region = region;
}

@end
