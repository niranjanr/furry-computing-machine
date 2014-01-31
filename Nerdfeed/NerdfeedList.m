//
//  NerdfeedList.m
//  Nerdfeed
//
//  Created by Niranjan Ravichandran on 1/27/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import "NerdfeedList.h"
#import "NerdfeedRSSChannel.h"

@implementation NerdfeedList

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  // TODO:
  return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  // TODO:
  return 0;
}

- (void)fetchEntries {
  self.xmlData = [[NSMutableData alloc] init];

  NSURL *url = [NSURL URLWithString:@"http://www.apple.com/pr/feeds/pr.rss"];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

- (id)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:style];

  if (self) {
    [self fetchEntries];
  }

  return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  [self.xmlData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  NSXMLParser *parser = [[NSXMLParser alloc] initWithData:self.xmlData];
  parser.delegate = self;
  [parser parse];

  self.xmlData = nil;
  self.connection = nil;

  [self.tableView reloadData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
  self.connection = nil;
  self.xmlData = nil;

  NSString *errorString = [NSString stringWithFormat:@"Fetch failed: %@", [error localizedDescription]];
  UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
  [av show];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
  NSLog(@"%@ found a %@ element", self, elementName);

  if ([elementName isEqualToString:@"channel"]) {
    self.channel = [[NerdfeedRSSChannel alloc] init];
    self.channel.parentParserDelegate = self;
    parser.delegate = (id)self.channel;
  }
}

@end
