//
//  NRViewController.m
//  Constraints
//
//  Created by Niranjan Ravichandran on 1/19/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import "NRViewController.h"

@interface NRViewController ()

@end

@implementation NRViewController

- (IBAction)buttonTapped:(UIButton *)sender
{
  if ([[sender titleForState:UIControlStateNormal] isEqualToString:@"X"]) {
    [sender setTitle:@"A very long title for this button"
            forState:UIControlStateNormal];
  } else {
    [sender setTitle:@"X" forState:UIControlStateNormal];
  }
}

@end
