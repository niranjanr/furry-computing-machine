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

    NSString *imagePath = [self imagePathForKey:s];
    NSData *d = UIImageJPEGRepresentation(i, 0.5);
    [d writeToFile:imagePath atomically:YES];
}

-(UIImage *)imageForKey:(NSString *)s {
    UIImage *result = [self.dictionary objectForKey:s];

    if (!result) {
        result = [UIImage imageWithContentsOfFile:[self imagePathForKey:s]];

        if (result) {
            [self.dictionary setObject:result forKey:s];
        } else {
            NSLog(@"Error: Unable to find %@", [self imagePathForKey:s]);
        }
    }

    return result;
}

-(void)deleteImageForKey:(NSString *)s {
    if (!s) {
        return;
    }
    [self.dictionary removeObjectForKey:s];

    NSString *path = [self imagePathForKey:s];
    [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
}

- (NSString *)imagePathForKey:(NSString *)key {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:key];
}

@end
