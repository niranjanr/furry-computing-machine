//
//  WebViewController.m
//  Nerdfeed
//
//  Created by Niranjan Ravichandran on 1/31/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController

- (void)loadView {
  CGRect screenFrame = [[UIScreen mainScreen] applicationFrame];
  UIWebView *wv = [[UIWebView alloc] initWithFrame:screenFrame];
  wv.scalesPageToFit = YES;
  [self setView:wv];
}

- (UIWebView *)webView {
  return (UIWebView *)self.view;
}

@end
