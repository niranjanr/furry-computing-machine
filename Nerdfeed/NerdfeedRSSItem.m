//
//  NerdfeedRSSItem.m
//  Nerdfeed
//
//  Created by Niranjan Ravichandran on 1/31/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import "NerdfeedRSSItem.h"

@implementation NerdfeedRSSItem

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
  NSLog(@"%@ found element named %@", self, elementName);

  if ([elementName isEqualToString:@"title"]) {
    self.currentString = [[NSMutableString alloc] init];
    self.title = self.currentString;
  } else if ([elementName isEqualToString:@"link"]) {
    self.currentString = [[NSMutableString alloc] init];
    self.link = self.currentString;
  }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
  [self.currentString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
  // relese this instance of the NSString since the corresponding permanent iVar already keeps track of this
  self.currentString = nil;

  if ([elementName isEqualToString:@"item"] ||
      [elementName isEqualToString:@"entry"]) {
    parser.delegate = self.parentParserDelegate;
  }
}

@end
