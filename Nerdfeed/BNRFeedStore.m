//
//  BNRFeedStore.m
//  Nerdfeed
//
//  Created by Niranjan Ravichandran on 2/1/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import "BNRFeedStore.h"
#import "NerdfeedRSSChannel.h"
#import "BNRConnection.h"

@implementation BNRFeedStore

+ (BNRFeedStore *)sharedStore {
  static BNRFeedStore *localStore;
  if (!localStore) {
    localStore = [[BNRFeedStore alloc] init];
  }
  return localStore;
}

- (void)fetchRSSFeedWithCompletion:(void(^)(NerdfeedRSSChannel *obj, NSError *err))block {
  NSURL *url = [NSURL URLWithString:@"http://www.apple.com/pr/feeds/pr.rss"];
  NSURLRequest *req = [NSURLRequest requestWithURL:url];

  NerdfeedRSSChannel *channel = [[NerdfeedRSSChannel alloc] init];

  BNRConnection *connection = [[BNRConnection alloc] initWithRequest:req];
  connection.completionBlock = block;
  connection.xmlRootObject = channel;
  [connection start];
}

@end
