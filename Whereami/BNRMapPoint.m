//
//  BNRMapPoint.m
//  Whereami
//
//  Created by Niranjan Ravichandran on 10/7/13.
//  Copyright (c) 2013 Niranjan Ravichandran. All rights reserved.
//

#import "BNRMapPoint.h"

@implementation BNRMapPoint

@synthesize coordinate;
@synthesize title;

- (id)initWithCoordinate:(CLLocationCoordinate2D)c
                   title:(NSString *)t {
    self = [super init];
    if (self) {
        self.coordinate = c;
        self.title = t;
    }
    return self;
}

- (id)init {
    return [self initWithCoordinate:CLLocationCoordinate2DMake(43.07, -89.32) title:@"Home"];
}


@end
