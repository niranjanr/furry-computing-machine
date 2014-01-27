//
//  ModalViewController.m
//  Storytime
//
//  Created by Niranjan Ravichandran on 1/27/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()

@end

@implementation ModalViewController

- (IBAction)dismiss:(id)sender {
  [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
