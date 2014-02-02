//
//  NerdfeedRSSChannel.h
//  Nerdfeed
//
//  Created by Niranjan Ravichandran on 1/30/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface NerdfeedRSSChannel : NSObject <NSXMLParserDelegate, JSONSerializable>

@property (nonatomic, weak) id parentParserDelegate;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *infoString;
@property (nonatomic, strong) NSMutableString *currentString;
@property (nonatomic, strong, readonly) NSMutableArray *items;

@end
