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

+ (id)allocWithZone:(struct _NSZone *)zone {
  return [self sharedStore];
}

#pragma mark instance methods
- (BNRItem *)createItem {
  double order;
  
  if ([self.allItems count] == 0) {
    order = 1.0;
  } else {
    order = [[[self.allItems lastObject] orderingValue] doubleValue] + 1.0;
  }
  
  NSLog(@"Adding after %d items, order = %.2f", [self.allItems count], order);
  
  BNRItem *p = [NSEntityDescription insertNewObjectForEntityForName:@"BNRItem"
                                             inManagedObjectContext:self.context];
  [p setOrderingValue:[NSNumber numberWithDouble:order]];
  
  [self.allItems addObject:p];
  
  return p;
}

- (void)removeItem:(BNRItem *)item {
  NSString *key = item.imageKey;
  [[BNRImageStore sharedStore] deleteImageForKey:key];
  [self.context deleteObject:item];
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
    
    [self loadAllItems];
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
  
  double lowerBound = 0.0;
  if (to > 0) {
    lowerBound = [[[self.allItems objectAtIndex:to - 1] orderingValue] doubleValue];
  } else {
    lowerBound = [[[self.allItems objectAtIndex:1] orderingValue] doubleValue] - 2.0;
  }
  
  double upperBound = 0.0;
  if (to < [self.allItems count] - 1) {
    upperBound = [[[self.allItems objectAtIndex:to+1] orderingValue] doubleValue];
  } else {
    upperBound = [[[self.allItems objectAtIndex:to-1] orderingValue] doubleValue] + 2.0;
  }
  
  double newOrderValue = (lowerBound + upperBound) / 2;
  NSLog(@"Moving to order %f", newOrderValue);
  [itemToMove setOrderingValue:[NSNumber numberWithDouble:newOrderValue]];
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
    NSEntityDescription *e =
    [[self.model entitiesByName] objectForKey:@"BNRItem"];
    request.entity = e;
    NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"orderingValue" ascending:YES];
    [request setSortDescriptors:@[sd]];
    
    NSError *error;
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    if (!result) {
      [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
    }
    self.allItems = [[NSMutableArray alloc] initWithArray:result];
  }
}

- (NSArray *)allAssetTypes {
  if (!_allAssetTypes) {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *e = [[self.model entitiesByName] objectForKey:@"BNRAssetType"];
    request.entity = e;
    
    NSError *error;
    NSArray *result = [self.context executeFetchRequest:request
                                                  error:&error];
    if (!result) {
      [NSException raise:@"Fetch failed"
                  format:@"Reason: %@", [error localizedDescription]];
    }
    _allAssetTypes = [result mutableCopy];
  }
  
  // --> if this is the first time that this application is being run,
  //     populate the asset types with some existing values
  if ([_allAssetTypes count] == 0) {
    NSManagedObject *type;
    
    type = [NSEntityDescription insertNewObjectForEntityForName:@"BNRAssetType"
                                         inManagedObjectContext:self.context];
    [type setValue:@"Furniture" forKey:@"label"];
    [_allAssetTypes addObject:type];
    

    type = [NSEntityDescription insertNewObjectForEntityForName:@"BNRAssetType"
                                         inManagedObjectContext:self.context];
    [type setValue:@"Jewelry" forKey:@"label"];
    [_allAssetTypes addObject:type];
    
    type = [NSEntityDescription insertNewObjectForEntityForName:@"BNRAssetType"
                                         inManagedObjectContext:self.context];
    [type setValue:@"Electronics" forKey:@"label"];
    [_allAssetTypes addObject:type];
  }
  
  return _allAssetTypes;
}

@end
