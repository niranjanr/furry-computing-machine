//
//  AppDelegate.m
//  TouchTracker
//
//  Created by Niranjan Ravichandran on 1/22/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import "AppDelegate.h"
#import "TouchViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  TouchViewController *mainViewController = [[TouchViewController alloc] init];
  self.window.rootViewController  = mainViewController;
  
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
  return YES;
}

@end
