//
//  BNRImageStore.h
//  Homepwner
//
//  Created by Niranjan R on 12/23/13.
//  Copyright (c) 2013 Niranjan Ravichandran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRImageStore : NSObject

@property (nonatomic, strong) NSMutableDictionary *dictionary;

+ (BNRImageStore *)sharedStore;

- (void)setImage:(UIImage *)i forKey:(NSString *)s;
- (UIImage *)imageForKey:(NSString *)s;
- (void)deleteImageForKey:(NSString *)s;
- (NSString *)imagePathForKey:(NSString *)key;

@end
