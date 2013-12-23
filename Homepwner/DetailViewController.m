//
//  DetailViewController.m
//  Homepwner
//
//  Created by Niranjan R on 12/22/13.
//  Copyright (c) 2013 Niranjan Ravichandran. All rights reserved.
//

#import "DetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize  item;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.nameField.text = self.item.itemName;
    self.serialNumberField.text = self.item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", self.item.valueInDollars];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    self.dateLabel.text = [dateFormatter stringFromDate:[item dateCreated]];

    NSString *imageKey = self.item.imageKey;
    if (imageKey) {
        UIImage *imageToBeDisplayed = [[BNRImageStore sharedStore] imageForKey:imageKey];
        self.imageView.image = imageToBeDisplayed;
    } else {
        self.imageView.image = nil;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.view endEditing:YES];

    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text integerValue];
}

- (void)setItem:(BNRItem *)it {
    item = it;
    self.navigationItem.title = item.itemName;
}

- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    } else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }

    imagePicker.delegate = self;

    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    NSString *oldKey = self.item.imageKey;
    if (oldKey) {
        [[BNRImageStore sharedStore] deleteImageForKey:oldKey];
    }

    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

    CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);

    NSString *key = (__bridge NSString*)newUniqueIDString;
    self.item.imageKey = key;

    [[BNRImageStore sharedStore] setImage:image forKey:key];

    CFRelease(newUniqueIDString);
    CFRelease(newUniqueId);

    self.imageView.image = image;

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
