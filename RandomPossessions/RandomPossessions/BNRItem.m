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

+ (id) randomItem {
    NSArray *randomAdjectiveList = [NSArray arrayWithObjects:@"Fluffy", @"Rusty", @"Shiny", nil];
    NSArray *randomNounList = [NSArray arrayWithObjects:@"Bear", @"Spork", @"Mac", nil];
    
    NSInteger adjectiveIndex = rand() % [randomAdjectiveList count];
    NSInteger nounIndex = rand() % [randomNounList count];
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@",
                            [randomAdjectiveList objectAtIndex:adjectiveIndex],
                            [randomNounList objectAtIndex:nounIndex]];
    
    NSInteger randomValue = rand() % 100;
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0' + rand() % 10,
                                    'A' + rand() % 26,
                                    '0' + rand() % 10,
                                    'A' + rand() % 26,
                                    '0' + rand() % 10];
    BNRItem *newItem = [[self alloc] initWithItemName:randomName valueInDollars:randomValue serialNumber:randomSerialNumber];
    return newItem;
}

@end
