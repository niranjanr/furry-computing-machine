//
//  main.m
//  RandomPossessions
//
//  Created by Niranjan Ravichandran on 10/6/13.
//  Copyright (c) 2013 Niranjan Ravichandran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // create a mutable array object & store its address in the 'items' variable
        NSMutableArray *items = [[NSMutableArray alloc] init];
        
        [items addObject:@"One"];
        [items addObject:@"Two"];
        [items addObject:@"Three"];
        
        [items insertObject:@"Zero" atIndex:0];
        
        for (int i = 0; i < items.count; i ++) {
            NSLog(@"%@", [items objectAtIndex:i]);
        }
        
        BNRItem *p = [[BNRItem alloc] init];
        NSLog(@"%@", p);
        p.itemName = @"Red Sofa";
        p.serialNumber = @"A1B2C3";
        p.valueInDollars = 100;
        
        NSLog(@"%@", p);
        // destroy the array pointed to by items
        items = nil;
    }
    return 0;
}

