//
//  BNRMapPoint.h
//  Whereami
//
//  Created by Niranjan Ravichandran on 10/7/13.
//  Copyright (c) 2013 Niranjan Ravichandran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface BNRMapPoint : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;

- (id)initWithCoordinate:(CLLocationCoordinate2D)c
                   title:(NSString *)t;

@end
