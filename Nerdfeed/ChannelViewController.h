//
//  ChannelViewController.h
//  Nerdfeed
//
//  Created by Niranjan Ravichandran on 2/1/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NerdfeedList.h"

@class NerdfeedRSSChannel;

@interface ChannelViewController : UITableViewController <ListViewControllerDelegate>

@property (nonatomic, strong) NerdfeedRSSChannel *channel;

@end
