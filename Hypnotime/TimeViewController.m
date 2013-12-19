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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nil bundle:nil];

    if (self) {
        UITabBarItem *item = self.tabBarItem;
        item.title = @"TimeView";

        UIImage *image = [UIImage imageNamed:@"Time.png"];
        item.image = image;
    }

    return self;
}

@end
