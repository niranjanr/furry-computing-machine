//
//  TimeViewController.h
//  Hypnotime
//
//  Created by Niranjan R on 12/18/13.
//  Copyright (c) 2013 Niranjan R. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel* timeLabel;

- (IBAction)showCurrentTime:(id)sender;

@end
