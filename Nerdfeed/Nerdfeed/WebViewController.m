//
//  WebViewController.m
//  Nerdfeed
//
//  Created by Niranjan Ravichandran on 1/31/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import "WebViewController.h"
#import "NerdfeedRSSItem.h"

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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    return YES;
  }
  return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)listViewController:(NerdfeedList *)lvc handleObject:(id)object {
  NerdfeedRSSItem *entry = object;

  if (![entry isKindOfClass:[NerdfeedRSSItem class]]) {
    return;
  }

  NSURL *url = [NSURL URLWithString:entry.link];
  NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
  [self.webView loadRequest:urlRequest];
  self.navigationItem.title = entry.title;
}

@end
