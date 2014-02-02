//
//  BNRFeedStore.m
//  Nerdfeed
//
//  Created by Niranjan Ravichandran on 2/1/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import "BNRFeedStore.h"

@implementation BNRFeedStore

+ (BNRFeedStore *)sharedStore {
  static BNRFeedStore *localStore;
  if (!localStore) {
    localStore = [[BNRFeedStore alloc] init];
  }
  return localStore;
}

- (void)fetchRSSFeedWithCompletion:(void(^)(NerdfeedRSSChannel *obj, NSError *err))block {
  // TODO:
}

@end
