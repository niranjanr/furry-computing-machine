//
//  JSONSerializable.h
//  Nerdfeed
//
//  Created by Niranjan Ravichandran on 2/2/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSONSerializable <NSObject>

- (void)readJSONFromDictionary:(NSDictionary *)dict;

@end
