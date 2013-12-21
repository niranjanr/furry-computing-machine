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
    NSBundle *appBundle = [NSBundle mainBundle];

    self = [super initWithNibName:@"TimeViewController" bundle:appBundle];

    if (self) {
        UITabBarItem *item = self.tabBarItem;
        item.title = @"TimeView";

        UIImage *image = [UIImage imageNamed:@"Time.png"];
        item.image = image;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor greenColor];

    NSLog(@"TimeViewController loaded its view");
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"CurrentTimeViewController will appear");
    [super viewWillAppear:animated];

    [self showCurrentTime:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"CurrentTimeViewController will disappear");
    [super viewWillDisappear:animated];
}
@end
