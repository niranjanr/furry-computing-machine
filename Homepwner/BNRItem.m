//
//  BNRItem.m
//  Homepwner
//
//  Created by Niranjan Ravichandran on 1/17/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem

@dynamic itemName;
@dynamic serialNumber;
@dynamic valueInDollars;
@dynamic dateCreated;
@dynamic imageKey;
@dynamic thumbnailData;
@dynamic thumbnail;
@dynamic orderingValue;
@dynamic assetType;

- (void)setThumbnailDataFromImage:(UIImage *)image {
  CGSize originalImageSize = [image size];
  
  // the rectangle of the thumbnail
  CGRect newRect = CGRectMake(0, 0, 40, 40);
  
  // figure out the scaling ratio to make sure we maintain the aspect ratio
  float ratio = MAX(newRect.size.width / originalImageSize.width,
                    newRect.size.height / originalImageSize.height);
  
  // create a transparent bitmap context with a scaling factor equal to that of the screen
  UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0);
  
  // create a path that is a rounded rectangle
  UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
  // make all the subsequent drawing clip to this rectangle
  [path addClip];
  
  // center the image in the thumbnail rectangle
  CGRect projectRect;
  projectRect.size.width = ratio * originalImageSize.width;
  projectRect.size.height = ratio * originalImageSize.height;
  projectRect.origin.x = (newRect.size.width - projectRect.size.width) / 2;
  projectRect.origin.y = (newRect.size.height - projectRect.size.height) / 2;
  
  // draw the image in it
  [image drawInRect:projectRect];
  
  // get the image from the image context and keep it as our thumbnail
  UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
  self.thumbnail = smallImage;
  
  // get the PNG representation of the image and save it as our thumbnail data
  NSData *data = UIImagePNGRepresentation(smallImage);
  self.thumbnailData = data;
  
  // clean up image context resources
  UIGraphicsEndImageContext();
}

- (void)awakeFromFetch {
  [super awakeFromFetch];
  
  UIImage *tn = [UIImage imageWithData:self.thumbnailData];
  [self setPrimitiveValue:tn forKey:@"thumbnail"];
}

- (void)awakeFromInsert {
  [super awakeFromInsert];
  
  NSTimeInterval t = [[NSDate date] timeIntervalSinceReferenceDate];
  self.dateCreated = [NSDate dateWithTimeIntervalSince1970:t];
}

@end
