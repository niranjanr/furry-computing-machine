//
//  DetailViewController.h
//  Homepwner
//
//  Created by Niranjan R on 12/22/13.
//  Copyright (c) 2013 Niranjan Ravichandran. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface DetailViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) BNRItem *item;

- (IBAction)takePicture:(id)sender;
- (IBAction)backgroundTapped:(id)sender;
@end
