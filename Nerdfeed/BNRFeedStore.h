//
//  BNRFeedStore.h
//  Nerdfeed
//
//  Created by Niranjan Ravichandran on 2/1/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@class NerdfeedRSSChannel;
@class NerdfeedRSSItem;

@interface BNRFeedStore : NSObject

+ (BNRFeedStore *)sharedStore;

@property (nonatomic, strong) NSDate *topSongsCachedDate;
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectModel *model;

- (NerdfeedRSSChannel *)fetchRSSFeedWithCompletion:(void(^)(NerdfeedRSSChannel *obj, NSError *err))block;
- (void)fetchTopSongs:(int)count  withCompletion:(void(^)(NerdfeedRSSChannel *obj, NSError *err))block;
- (void)markItemAsRead:(NerdfeedRSSItem *)item;
- (BOOL)hasItemBeenRead:(NerdfeedRSSItem *)item;

@end
