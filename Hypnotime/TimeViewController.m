//
//  TimeViewController.m
//  Hypnotime
//
//  Created by Niranjan R on 12/18/13.
//  Copyright (c) 2013 Niranjan R. All rights reserved.
//

#import "TimeViewController.h"

@implementation TimeViewController

- (void)showCurrentTime:(id)sender {
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeStyle = NSDateFormatterMediumStyle;
    self.timeLabel.text = [dateFormatter stringFromDate:now];
    NSLog(@"We are now showing the current time");
}

@end
