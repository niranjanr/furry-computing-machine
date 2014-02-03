//
//  NerdfeedRSSItem.h
//  Nerdfeed
//
//  Created by Niranjan Ravichandran on 1/31/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface NerdfeedRSSItem : NSObject <NSXMLParserDelegate, JSONSerializable, NSCoding>

@property (nonatomic, strong) NSMutableString *currentString;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSDate *publicationDate;

@property (nonatomic, weak) id parentParserDelegate;

@end
