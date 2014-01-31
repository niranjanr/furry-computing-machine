//
//  NerdfeedRSSChannel.m
//  Nerdfeed
//
//  Created by Niranjan Ravichandran on 1/30/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import "NerdfeedRSSChannel.h"

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
    self.currentString = [elementName copy];
    self.title = self.currentString;
  } else if ([elementName isEqualToString:@"description"]) {
    self.currentString = [elementName copy];
    self.infoString = self.currentString;
  }
}
@end
