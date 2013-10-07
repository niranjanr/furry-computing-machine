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
        
        for (int i = 0; i < 10; i++) {
            BNRItem *p = [BNRItem randomItem];
            [items addObject:p];
            NSLog(@"%@", p);
        }
        
        // destroy the array pointed to by items
        items = nil;
    }
    return 0;
}

