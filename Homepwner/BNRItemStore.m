//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Niranjan Ravichandran on 12/20/13.
//  Copyright (c) 2013 Niranjan Ravichandran. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@implementation BNRItemStore

@synthesize allItems;

#pragma mark singleton methods
+(BNRItemStore *)sharedStore {
    static BNRItemStore *sharedItemStore = nil;
    
    if (!sharedItemStore) {
        sharedItemStore = [[super allocWithZone:nil] init];
    }
    
    return sharedItemStore;
}

+(id)allocWithZone:(struct _NSZone *)zone {
    return [self sharedStore];
}

#pragma mark instance methods
- (BNRItem *)createItem {
    BNRItem *item = [BNRItem randomItem];
    
    [self.allItems addObject:item];
    
    return item;
}

- (void)removeItem:(BNRItem *)item {
    [self.allItems removeObjectIdenticalTo:item];
}


- (id)init {
    self = [super init];
    
    if (self) {
        self.allItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)moveItemAtIndex:(int)from toIndex:(int)to {
    if (from == to) {
        return;
    }

    BNRItem *itemToMove = [self.allItems objectAtIndex:from];
    [self.allItems removeObjectAtIndex:from];
    [self.allItems insertObject:itemToMove atIndex:to];
}

@end
