//
//  NerdfeedAppDelegate.m
//  Nerdfeed
//
//  Created by Niranjan Ravichandran on 1/27/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import "NerdfeedAppDelegate.h"
#import "NerdfeedList.h"
#import "WebViewController.h"

@implementation NerdfeedAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  NerdfeedList *lvc = [[NerdfeedList alloc] initWithStyle:UITableViewStylePlain];
  UINavigationController *mvc = [[UINavigationController alloc] initWithRootViewController:lvc];

  WebViewController *wvc = [[WebViewController alloc] init];
  [lvc setWebViewController:wvc];

  self.window.rootViewController = mvc;

  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
  return YES;
}

@end
