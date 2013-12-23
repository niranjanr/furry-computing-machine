//
//  BNRImageStore.m
//  Homepwner
//
//  Created by Niranjan R on 12/23/13.
//  Copyright (c) 2013 Niranjan Ravichandran. All rights reserved.
//

#import "BNRImageStore.h"

@implementation BNRImageStore

+(id)allocWithZone:(struct _NSZone *)zone {
    return [self sharedStore];
}

+(BNRImageStore *)sharedStore {
    static BNRImageStore *staticStore = nil;

    if (!staticStore) {
        staticStore = [[super allocWithZone:NULL] init];
    }

    return staticStore;
}

-(id)init {
    self = [super init];
    if (self) {
        self.dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)setImage:(UIImage *)i forKey:(NSString *)s {
    [self.dictionary setObject:i forKey:s];
}

-(UIImage *)imageForKey:(NSString *)s {
    return [self.dictionary objectForKey:s];
}

-(void)deleteImageForKey:(NSString *)s {
    if (!s) {
        return;
    }
    [self.dictionary removeObjectForKey:s];
}

@end
