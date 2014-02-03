//
//  BNRFeedStore.h
//  Nerdfeed
//
//  Created by Niranjan Ravichandran on 2/1/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NerdfeedRSSChannel;

@interface BNRFeedStore : NSObject

+ (BNRFeedStore *)sharedStore;

@property (nonatomic, strong) NSDate *topSongsCachedDate;

- (NerdfeedRSSChannel *)fetchRSSFeedWithCompletion:(void(^)(NerdfeedRSSChannel *obj, NSError *err))block;
- (void)fetchTopSongs:(int)count  withCompletion:(void(^)(NerdfeedRSSChannel *obj, NSError *err))block;

@end
