//
//  HomepwnerItemCell.m
//  Homepwner
//
//  Created by Niranjan Ravichandran on 1/2/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import "HomepwnerItemCell.h"

@implementation HomepwnerItemCell

- (IBAction)showImage:(id)sender {
  NSString *selector = NSStringFromSelector(_cmd);
  selector = [selector stringByAppendingString:@"atIndexPath:"];
  SEL newSelector = NSSelectorFromString(selector);

  NSIndexPath *indexPath = [self.tableView indexPathForCell:self];

  if (indexPath) {
    if ([self.controller respondsToSelector:newSelector]) {
      [self.controller performSelector:newSelector
                            withObject:sender
                            withObject:indexPath];
    }
  }
}

@end
