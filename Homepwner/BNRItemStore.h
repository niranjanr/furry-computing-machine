//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Niranjan Ravichandran on 12/20/13.
//  Copyright (c) 2013 Niranjan Ravichandran. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface BNRItemStore : NSObject

@property (nonatomic, strong) NSMutableArray* allItems;

- (BNRItem *)createItem;
- (void)removeItem:(BNRItem *)item;
- (void)moveItemAtIndex:(int)from toIndex:(int)to;


+(BNRItemStore *)sharedStore;

@end
