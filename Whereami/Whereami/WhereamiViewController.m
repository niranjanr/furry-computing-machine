//
//  WhereamiViewController.m
//  Whereami
//
//  Created by Niranjan Ravichandran on 10/6/13.
//  Copyright (c) 2013 Niranjan Ravichandran. All rights reserved.
//

#import "WhereamiViewController.h"
#import "BNRMapPoint.h"

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

// text field delegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self findLocation];
    [textField resignFirstResponder];
    return YES;
}

// location manager delegate methods
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"%@", newLocation);

    // How many seconds ago was this new location created
    NSTimeInterval t = [[newLocation timestamp] timeIntervalSinceNow];

    // * CLLocationManager will return the last found location of the device first
    //   and we do not want that data in this case
    // * If this location was made more than 3 minutes ago, ignore it
    if (t < -180) {
        // this is cached data, you don't want it, keep looking
        return;
    }

    [self foundLocation:newLocation];
}

// map view delegate methods
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    CLLocationCoordinate2D loc = userLocation.coordinate;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    self.worldView.region = region;
}

- (void) findLocation {
    [self.locationManager startUpdatingLocation];
    [self.activityIndicator startAnimating];
    self.locationTextField.hidden = YES;
}

- (void) foundLocation:(CLLocation *)loc {
    CLLocationCoordinate2D coord = loc.coordinate;

    // create an instance of BNRMapPoint with the current data
    BNRMapPoint *mp = [[BNRMapPoint alloc] initWithCoordinate:coord title:self.locationTextField.text];

    // add it to the map view
    [self.worldView addAnnotation:mp];

    // zoom the region to this location
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250, 250);
    [self.worldView setRegion:region animated:YES];

    // Reset the UI
    self.locationTextField.text = @"";
    [self.activityIndicator stopAnimating];
    self.locationTextField.hidden = NO;
    [self.locationManager stopUpdatingLocation];
}

@end
