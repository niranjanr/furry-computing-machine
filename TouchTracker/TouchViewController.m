//
//  TouchViewController.m
//  TouchTracker
//
//  Created by Niranjan Ravichandran on 1/22/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import "TouchViewController.h"
#import "TouchDrawView.h"

@implementation TouchViewController

- (void)loadView {
  self.view = [[TouchDrawView alloc] initWithFrame:CGRectZero];
}

@end
