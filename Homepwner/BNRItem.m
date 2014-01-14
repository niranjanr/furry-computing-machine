//
//  BNRItem.m
//  RandomPossessions
//
//  Created by joeconway on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem
@synthesize container;
@synthesize containedItem;
@synthesize itemName;
@synthesize serialNumber;
@synthesize dateCreated;
@synthesize valueInDollars;
@synthesize imageKey;

+ (id)randomItem
{
    // Create an array of three adjectives
    NSArray *randomAdjectiveList = [NSArray arrayWithObjects:@"Fluffy",
                                    @"Rusty",
                                    @"Shiny", nil];
    // Create an array of three nouns
    NSArray *randomNounList = [NSArray arrayWithObjects:@"Bear",
                               @"Spork",
                               @"Mac", nil];
    // Get the index of a random adjective/noun from the lists
    // Note: The % operator, called the modulo operator, gives
    // you the remainder. So adjectiveIndex is a random number
    // from 0 to 2 inclusive.
    NSInteger adjectiveIndex = rand() % [randomAdjectiveList count];
    NSInteger nounIndex = rand() % [randomNounList count];
    
    // Note that NSInteger is not an object, but a type definition
    // for "unsigned long"
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@",
                            [randomAdjectiveList objectAtIndex:adjectiveIndex],
                            [randomNounList objectAtIndex:nounIndex]];
    int randomValue = rand() % 100;
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0' + rand() % 10,
                                    'A' + rand() % 26,
                                    '0' + rand() % 10,
                                    'A' + rand() % 26,
                                    '0' + rand() % 10];
    // Once again, ignore the memory problems with this method
    BNRItem *newItem =
    [[self alloc] initWithItemName:randomName
                    valueInDollars:randomValue
                      serialNumber:randomSerialNumber];
    return newItem;
}

- (id)initWithItemName:(NSString *)name
        valueInDollars:(int)value
          serialNumber:(NSString *)sNumber
{
    // Call the superclass's designated initializer
    self = [super init];
    
    // Did the superclass's designated initializer succeed?
    if(self) {
        // Give the instance variables initial values
        [self setItemName:name];
        [self setSerialNumber:sNumber];
        [self setValueInDollars:value];
        dateCreated = [[NSDate alloc] init];
    }
    
    // Return the address of the newly initialized object
    return self;
}

- (id)init 
{
    return [self initWithItemName:@"Possession"
                   valueInDollars:0
                     serialNumber:@""];
}


- (void)setContainedItem:(BNRItem *)i
{
    containedItem = i;
    [i setContainer:self];
}

- (NSString *)description
{
    NSString *descriptionString =
    [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, recorded on %@",
     itemName,
     serialNumber,
     valueInDollars,
     dateCreated];
    return descriptionString;
}

- (void)dealloc
{
    NSLog(@"Destroyed: %@ ", self);
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.itemName forKey:@"itemName"];
    [aCoder encodeObject:self.serialNumber forKey:@"serialNumber"];
    [aCoder encodeObject:self.dateCreated forKey:@"dateCreated"];
    [aCoder encodeObject:self.imageKey forKey:@"imageKey"];
    [aCoder encodeInteger:self.valueInDollars forKey:@"valueInDollars"];
    [aCoder encodeObject:self.thumbnailData forKey:@"thumbnailData"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.itemName = [aDecoder decodeObjectForKey:@"itemName"];
        self.serialNumber = [aDecoder decodeObjectForKey:@"serialNumber"];
        self.dateCreated = [aDecoder decodeObjectForKey:@"dateCreated"];
        self.imageKey = [aDecoder decodeObjectForKey:@"imageKey"];
        self.valueInDollars = [aDecoder decodeIntegerForKey:@"valueInDollars"];
        self.thumbnailData = [aDecoder decodeObjectForKey:@"thumbnailData"];
    }
    return self;
}


- (UIImage *)thumbnail {
  // if there is no thumbnail data, don't return anything
  if (!self.thumbnailData) {
    return nil;
  }

  if (!_thumbnail) {
    _thumbnail = [UIImage imageWithData:self.thumbnailData];
  }
  return _thumbnail;
}

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

@end
