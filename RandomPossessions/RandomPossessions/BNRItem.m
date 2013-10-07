//
//  BNRItem.m
//  RandomPossessions
//
//  Created by Niranjan Ravichandran on 10/6/13.
//  Copyright (c) 2013 Niranjan Ravichandran. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem

@synthesize itemName;
@synthesize serialNumber;
@synthesize dateCreated;
@synthesize valueInDollars;

- (NSString *)description {
    NSString *descriptionString = [[NSString alloc]
                                   initWithFormat:@"%@ (%@): Worth %d recorded on %@", self.itemName, self.serialNumber, self.valueInDollars, self.dateCreated];
    return descriptionString;
}

- (id) initWithItemName: (NSString *)name
         valueInDollars: (NSInteger)dollars
           serialNumber: (NSString *)serial {
    self = [super init];
    if (self) {
        self.itemName = name;
        self.valueInDollars = dollars;
        self.serialNumber = serial;
        self.dateCreated = [[NSDate alloc] init];
    }
    return self;
}

- (id) init {
    return [self initWithItemName:@"Item" valueInDollars:0 serialNumber:@""];
}

@end
