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

- (void)fetchTopSongs:(int)count  withCompletion:(void(^)(NerdfeedRSSChannel *obj, NSError *err))block {
  NSString *cachePath = [NSSearchPathForDirectoriesInDomains(
                                                             NSCachesDirectory,
                                                             NSUserDomainMask,
                                                             YES) objectAtIndex:0];
  cachePath =[cachePath stringByAppendingString:@"apple.archive"];
  NSDate *tscd = self.topSongsCachedDate;
  if (tscd) {
    NSTimeInterval cacheAge = [self.topSongsCachedDate timeIntervalSinceNow];
    if (cacheAge > -300) {
      NSLog(@"Reading cache");
      NerdfeedRSSChannel *cachedChannel = [NSKeyedUnarchiver unarchiveObjectWithFile:cachePath];
      if (cachedChannel) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
          block(cachedChannel, nil);
        }];
        return;
      }
    }
  }

  NSString *requestString = [NSString stringWithFormat:@"https://itunes.apple.com/us/rss/topsongs/limit=%d/json", count];
  NSURL *url = [NSURL URLWithString:requestString];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  NerdfeedRSSChannel *channel = [[NerdfeedRSSChannel alloc] init];
  BNRConnection *connection = [[BNRConnection alloc] initWithRequest:request];
  connection.jsonRootObject = channel;
  connection.completionBlock = ^(NerdfeedRSSChannel *obj, NSError *err) {
    if (!err) {
      self.topSongsCachedDate = [NSDate date];
      [NSKeyedArchiver archiveRootObject:obj toFile:cachePath];
    }
    block(obj, err);
  };

  [connection start];
}

#pragma mark topSongsCachedDate methods

- (NSDate *)topSongsCachedDate {
  return [[NSUserDefaults standardUserDefaults] objectForKey:@"topSongsCachedDate"];
}

- (void)setTopSongsCachedDate:(NSDate *)topSongsCachedDate {
  [[NSUserDefaults standardUserDefaults] setObject:topSongsCachedDate forKey:@"topSongsCachedDate"];
}

@end
