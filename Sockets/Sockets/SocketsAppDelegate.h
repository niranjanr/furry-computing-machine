//
//  SocketsAppDelegate.h
//  Sockets
//
//  Created by Niranjan Ravichandran on 1/29/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SRWebSocket.h>

@interface SocketsAppDelegate : UIResponder <UIApplicationDelegate, SRWebSocketDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
