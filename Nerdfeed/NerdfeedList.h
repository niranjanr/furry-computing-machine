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

@interface NerdfeedList : UITableViewController <NSURLConnectionDataDelegate, NSXMLParserDelegate>

@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *xmlData;
@property (nonatomic, strong) NerdfeedRSSChannel *channel;
@property (nonatomic, strong) WebViewController *webViewController;

@end


@protocol ListViewControllerDelegate

- (void)listViewController:(NerdfeedList *)lvc handleObject:(id)object;

@end
