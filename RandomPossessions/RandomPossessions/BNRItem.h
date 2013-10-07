//
//  BNRItem.h
//  RandomPossessions
//
//  Created by Niranjan Ravichandran on 10/6/13.
//  Copyright (c) 2013 Niranjan Ravichandran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject

@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *serialNumber;
@property (nonatomic, strong) NSDate *dateCreated;
@property (nonatomic) int valueInDollars;

- (id) initWithItemName: (NSString *)name
         valueInDollars: (NSInteger)dollars
           serialNumber: (NSString *)serialNumber;

@end
