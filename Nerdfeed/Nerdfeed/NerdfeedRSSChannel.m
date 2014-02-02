//
//  NerdfeedRSSChannel.m
//  Nerdfeed
//
//  Created by Niranjan Ravichandran on 1/30/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import "NerdfeedRSSChannel.h"
#import "NerdfeedRSSItem.h"

@implementation NerdfeedRSSChannel

- (id)init {
  self = [super init];
  if (self) {
    _items = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
  NSLog(@"%@ found element named %@", self, elementName);

  if ([elementName isEqualToString:@"title"]) {
    self.currentString = [elementName mutableCopy];
    self.title = self.currentString;
  } else if ([elementName isEqualToString:@"description"]) {
    self.currentString = [elementName mutableCopy];
    self.infoString = self.currentString;
  } else if ([elementName isEqualToString:@"item"] ||
             [elementName isEqualToString:@"entry"]) {
    NerdfeedRSSItem *entry = [[NerdfeedRSSItem alloc] init];
    entry.parentParserDelegate = (id)self;
    parser.delegate = entry;
    [self.items addObject:entry];
  }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
  [self.currentString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
  // relese this instance of the NSString since the corresponding permanent iVar already keeps track of this
  self.currentString = nil;

  if ([elementName isEqualToString:@"channel"]) {
    parser.delegate = self.parentParserDelegate;
  }
}

- (void)readJSONFromDictionary:(NSDictionary *)dict {
  NSDictionary *feed = [dict objectForKey:@"feed"];
  self.title = [[feed objectForKey:@"title"] objectForKey:@"label"];

  NSArray *entries = [feed objectForKey:@"entry"];
  for (NSDictionary *entry in entries) {
    NerdfeedRSSItem *i = [[NerdfeedRSSItem alloc] init];
    [i readJSONFromDictionary:entry];
    [self.items addObject:i];
  }
}

@end
