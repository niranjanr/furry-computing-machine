//
//  NerdfeedList.m
//  Nerdfeed
//
//  Created by Niranjan Ravichandran on 1/27/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import "NerdfeedList.h"
#import "NerdfeedRSSChannel.h"
#import "NerdfeedRSSItem.h"
#import "ChannelViewController.h"
#import "BNRFeedStore.h"

@implementation NerdfeedList

#pragma mark TableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
  }
  NerdfeedRSSItem *item = [self.channel.items objectAtIndex:indexPath.row];
  cell.textLabel.text = item.title;
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[self.channel items] count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (!self.splitViewController) {
    [self.navigationController pushViewController:(UIViewController *)self.webViewController animated:YES];
  } else {
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:(id)self.webViewController];
    NSArray *vcs = @[self.navigationController, nvc];
    self.splitViewController.viewControllers = vcs;
    self.splitViewController.delegate = (id)self.webViewController;
  }

  NerdfeedRSSItem *entry = [self.channel.items objectAtIndex:indexPath.row];
  [(id)self.webViewController listViewController:self handleObject:entry];
}

- (id)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:style];

  if (self) {
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithTitle:@"Info" style:UIBarButtonItemStyleBordered target:self action:@selector(showInfo:)];
    self.navigationItem.rightBarButtonItem = bbi;
    [self fetchEntries];
  }

  return self;
}

- (void)showInfo:(id)sender {
  ChannelViewController *channelViewController = [[ChannelViewController alloc] initWithStyle:UITableViewStyleGrouped];

  if (self.splitViewController) {
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:channelViewController];
    NSArray *vcs = @[self.navigationController, nvc];
    self.splitViewController.viewControllers = vcs;
    self.splitViewController.delegate = (id)channelViewController;

    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    if (selectedIndexPath) {
      [self.tableView deselectRowAtIndexPath:selectedIndexPath animated:YES];
    }
  } else {
    [self.navigationController pushViewController:channelViewController animated:YES];
  }
  [channelViewController listViewController:self handleObject:self.channel];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    return YES;
  }
  return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark XML parsing and objects related stuff

- (void)fetchEntries {
  [[BNRFeedStore sharedStore] fetchRSSFeedWithCompletion:^(NerdfeedRSSChannel *obj, NSError *err) {
    if (!err) {
      self.channel = obj;
      [self.tableView reloadData];
    } else {
      UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error" message:[err localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
      [av show];
    }
  }];
}

@end
