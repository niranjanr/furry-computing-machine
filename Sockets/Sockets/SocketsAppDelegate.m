//
//  SocketsAppDelegate.m
//  Sockets
//
//  Created by Niranjan Ravichandran on 1/29/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import "SocketsAppDelegate.h"
#import <SRWebSocket.h>
#import "MessageTableViewController.h"

static SRWebSocket *mySocket = nil;
static MessageTableViewController *mvc = nil;

@implementation SocketsAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  SRWebSocket *socket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:@"ws://localhost:8080"]];
  socket.delegate = self;
  [socket open];
  
  mvc = [[MessageTableViewController alloc] initWithStyle:UITableViewStylePlain];
  self.window.rootViewController = mvc;
  
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark WebSocket delegate methods
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
  NSLog (@"WebSocket: Received message: %@", message);
  [mvc.messages insertObject:message atIndex:0];
  [mvc.tableView reloadData];
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
  NSLog(@"WebSocket: Opened");

  mySocket = webSocket;
  [mySocket send:@"message"];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
  NSLog(@"WebSocket: Failed: %@", [error localizedDescription]);
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
  NSLog(@"WebSocket: Closed: Code: %d, Reason: %@, CLEAN: %d", code, reason, wasClean);
}

@end
