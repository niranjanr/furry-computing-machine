//
//  HomepwnerViewController.m
//  StrutsProblem
//
//  Created by Niranjan Ravichandran on 1/19/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import "HomepwnerViewController.h"

@interface HomepwnerViewController ()
@property (weak, nonatomic) IBOutlet UIView *topLeftView;
@property (weak, nonatomic) IBOutlet UIView *topRightView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation HomepwnerViewController

- (void)viewWillLayoutSubviews {
  if(UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
    CGRect rect = self.topLeftView.frame;
    rect.size.width = 254;
    rect.size.height = 130;
    self.topLeftView.frame = rect;
    
    rect = self.topRightView.frame;
    rect.origin.x = 294;
    rect.size.width = 254;
    rect.size.height = 130;
    self.topRightView.frame = rect;
    
    rect = self.bottomView.frame;
    rect.origin.y = 170;
    rect.size.width = 528;
    rect.size.height = 130;
    self.bottomView.frame = rect;
  } else {
    CGRect rect = self.topLeftView.frame;
    rect.size.width = 130;
    rect.size.height = 254;
    self.topLeftView.frame = rect;
    
    rect = self.topRightView.frame;
    rect.origin.x = 170;
    rect.size.width = 130;
    rect.size.height = 254;
    self.topRightView.frame = rect;
    
    rect = self.bottomView.frame;
    rect.origin.y = 295;
    rect.size.width = 280;
    rect.size.height = 254;
    self.bottomView.frame = rect;
  }
}

@end
