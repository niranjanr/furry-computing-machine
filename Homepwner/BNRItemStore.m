//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Niranjan Ravichandran on 12/20/13.
//  Copyright (c) 2013 Niranjan Ravichandran. All rights reserved.
//

#import "BNRImageStore.h"
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
    BNRItem *item = [[BNRItem alloc] init];
    
    [self.allItems addObject:item];
    
    return item;
}

- (void)removeItem:(BNRItem *)item {
    NSString *key = item.imageKey;
    [[BNRImageStore sharedStore] deleteImageForKey:key];
    [self.allItems removeObjectIdenticalTo:item];
}

- (id)init {
    self = [super init];
    
    if (self) {
        NSString *path = [self itemArchivePath];
        self.allItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (!self.allItems) {
            self.allItems = [[NSMutableArray alloc] init];
        }
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

- (NSString *)itemArchivePath {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    NSString *documentDirectory = [documentDirectories objectAtIndex:0];

    return [documentDirectory stringByAppendingString:@"items.archive"];
}

- (BOOL)saveChanges {
    NSString *path = self.itemArchivePath;

    return [NSKeyedArchiver archiveRootObject:self.allItems toFile:path];
}

@end
