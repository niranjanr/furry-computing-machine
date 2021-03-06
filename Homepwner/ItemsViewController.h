//
//  ItemsViewController.h
//  Homepwner
//
//  Created by Niranjan Ravichandran on 12/20/13.
//  Copyright (c) 2013 Niranjan Ravichandran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemsViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UIPopoverControllerDelegate> {
}

@property (nonatomic, strong) UIPopoverController *imagePopover;

- (IBAction)addNewItem:(id)sender;

@end
