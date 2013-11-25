//
//  WhereamiAppDelegate.m
//  Hypnosister
//
//  Created by Niranjan Ravichandran on 11/24/13.
//  Copyright (c) 2013 Niranjan Ravichandran. All rights reserved.
//

#import "WhereamiAppDelegate.h"

@implementation WhereamiAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
