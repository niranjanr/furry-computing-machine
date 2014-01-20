//
//  BNRItem.h
//  Homepwner
//
//  Created by Niranjan Ravichandran on 1/17/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BNRItem : NSManagedObject

@property (nonatomic, retain) NSString *itemName;
@property (nonatomic, retain) NSString *serialNumber;
@property (nonatomic, retain) NSNumber *valueInDollars;
@property (nonatomic, retain) NSDate *dateCreated;
@property (nonatomic, retain) NSString *imageKey;
@property (nonatomic, retain) NSData *thumbnailData;
@property (nonatomic, retain) UIImage *thumbnail;
@property (nonatomic, retain) NSNumber *orderingValue;
@property (nonatomic, retain) NSManagedObject *assetType;

- (void)setThumbnailDataFromImage:(UIImage *)image;

@end
