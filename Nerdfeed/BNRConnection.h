//
//  BNRConnection.h
//  Nerdfeed
//
//  Created by Niranjan Ravichandran on 2/2/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface BNRConnection : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, strong) id<NSXMLParserDelegate> xmlRootObject;
@property (nonatomic, strong) id<JSONSerializable> jsonRootObject;
@property (nonatomic, strong) NSURLConnection *internalConnection;
@property (nonatomic, strong) NSMutableData *container;
@property (nonatomic, copy) NSURLRequest *request;
@property (nonatomic, copy) void (^completionBlock)(id obj, NSError *err);

- (id)initWithRequest:(NSURLRequest *)req;
- (void)start;

@end
