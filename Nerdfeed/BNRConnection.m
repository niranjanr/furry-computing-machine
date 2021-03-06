//
//  BNRConnection.m
//  Nerdfeed
//
//  Created by Niranjan Ravichandran on 2/2/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import "BNRConnection.h"

static NSMutableArray *sharedConnectionList = nil;

@implementation BNRConnection

- (instancetype)initWithRequest:(NSURLRequest *)req {
  self = [super init];
  if (self) {
    self.request = req;
  }
  return self;
}

- (void)start {
  self.container = [[NSMutableData alloc] init];
  self.internalConnection = [NSURLConnection connectionWithRequest:self.request delegate:self];
  if (!sharedConnectionList) {
    sharedConnectionList = [[NSMutableArray alloc] init];
  }
  [sharedConnectionList addObject:self];

  [self.internalConnection start];
}

#pragma mark Delegate methods for NSURLConnection

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  [self.container appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  id rootObject = nil;
  if (self.xmlRootObject) {
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:self.container];
    parser.delegate = self.xmlRootObject;
    [parser parse];

    rootObject = self.xmlRootObject;
  } else if (self.jsonRootObject) {
    NSDictionary *d = [NSJSONSerialization JSONObjectWithData:self.container
                                                      options:0
                                                        error:nil];
    [self.jsonRootObject readJSONFromDictionary:d];
    rootObject = self.jsonRootObject;
  }

  if (self.completionBlock) {
    self.completionBlock(rootObject, nil);
  }

  [sharedConnectionList removeObject:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
  if (self.completionBlock) {
    self.completionBlock(nil, error);
  }

  [sharedConnectionList removeObject:self];
}

@end
