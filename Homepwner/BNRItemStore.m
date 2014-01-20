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
    // BNRItem *item = [[BNRItem alloc] init];
    BNRItem *item = [BNRItem randomItem];
    
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
      self.model = [NSManagedObjectModel mergedModelFromBundles:nil];
      NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
      
      NSString *path = [self itemArchivePath];
      NSURL *storeUrl = [NSURL fileURLWithPath:path];
      NSError *error = nil;
      
      if (![psc addPersistentStoreWithType:NSSQLiteStoreType
                             configuration:nil
                                       URL:storeUrl
                                   options:nil
                                     error:&error]) {
        [NSException raise:@"Open failed" format:@"Reason: %@", [error localizedDescription]];
      }
      
      self.context = [[NSManagedObjectContext alloc] init];
      self.context.persistentStoreCoordinator = psc;
      self.context.undoManager = nil;
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

    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

- (BOOL)saveChanges {
  NSError *error = nil;
  
  BOOL successful = [self.context save:&error];
  if (!successful) {
    NSLog(@"Error saving: %@", [error localizedDescription]);
  }
  return successful;
}

- (void)loadAllItems {
  if (!self.allItems) {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *e = [self.model.entitiesByName]
  }
}
@end
