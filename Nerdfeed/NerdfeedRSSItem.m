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
  } else if ([elementName isEqualToString:@"pubDate"]) {
    self.currentString = [[NSMutableString alloc] init];
  }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
  [self.currentString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
  if ([elementName isEqualToString:@"pubDate"]) {
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
      dateFormatter = [[NSDateFormatter alloc] init];
      [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss z"];
      self.publicationDate = [dateFormatter dateFromString:self.currentString];
    }
  }
  // relese this instance of the NSString since the corresponding permanent iVar already keeps track of this
  self.currentString = nil;

  if ([elementName isEqualToString:@"item"] ||
      [elementName isEqualToString:@"entry"]) {
    parser.delegate = self.parentParserDelegate;
  }
}

- (void)readJSONFromDictionary:(NSDictionary *)dict {
  self.title = [[dict objectForKey:@"title"] objectForKey:@"label"];

  NSArray *links = [dict objectForKey:@"link"];
  if (links.count > 1) {
    NSDictionary *sampleDict = [[links objectAtIndex:1] objectForKey:@"attributes"];
    self.link = [sampleDict objectForKey:@"href"];
  }
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.title forKey:@"title"];
  [aCoder encodeObject:self.link forKey:@"link"];
  [aCoder encodeObject:self.publicationDate forKey:@"publicationDate"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];

  if (self) {
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.link = [aDecoder decodeObjectForKey:@"link"];
    self.publicationDate = [aDecoder decodeObjectForKey:@"publicationDate"];
  }
  return self;
}

-(BOOL)isEqual:(id)object {
  if (![object isKindOfClass:[NerdfeedRSSItem class]]) {
    return NO;
  }
  return [self.link isEqual:[object link]];
}

@end
