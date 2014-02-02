//
//  NerdfeedList.h
//  Nerdfeed
//
//  Created by Niranjan Ravichandran on 1/27/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NerdfeedRSSChannel;
@class WebViewController;

typedef enum {
  ListViewControllerRSSTypeBNR,
  ListviewControllerRSSTypeApple
} ListViewControllerRSSType;

@interface NerdfeedList : UITableViewController <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NerdfeedRSSChannel *channel;
@property (nonatomic, strong) WebViewController *webViewController;
@property (nonatomic) ListViewControllerRSSType rssType;

@end


@protocol ListViewControllerDelegate

- (void)listViewController:(NerdfeedList *)lvc handleObject:(id)object;

@end
