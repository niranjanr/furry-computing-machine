//
//  ChannelViewController.m
//  Nerdfeed
//
//  Created by Niranjan Ravichandran on 2/1/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import "ChannelViewController.h"
#import "NerdfeedRSSChannel.h"

@implementation ChannelViewController

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"UITableViewCell"];
  }
  
  if (indexPath.row == 0) {
    cell.textLabel.text = @"Title";
    cell.detailTextLabel.text = self.channel.title;
  } else if (indexPath.row == 1) {
    cell.textLabel.text = @"Info";
    cell.detailTextLabel.text = self.channel.infoString;
  }
  return cell;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    return YES;
  }
  return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)listViewController:(NerdfeedList *)lvc handleObject:(id)object {
  if (![object isKindOfClass:[NerdfeedRSSChannel class]]) {
    return;
  }
  
  self.channel = object;
  [self.tableView reloadData];
}
@end
