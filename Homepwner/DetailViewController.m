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
#import "BNRItemStore.h"
#import "AssetTypePicker.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize item;
@synthesize imagePickerPopover;
@synthesize dismissBlock;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIColor *clr = nil;
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    clr = [UIColor colorWithRed:0.875 green:0.88 blue:0.91 alpha:1.0];
  } else {
    clr = [UIColor groupTableViewBackgroundColor];
  }
  self.view.backgroundColor = clr;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  self.nameField.text = self.item.itemName;
  self.serialNumberField.text = self.item.serialNumber;
  self.valueField.text = [NSString stringWithFormat:@"%@", self.item.valueInDollars];
  
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
  
  NSString *typeLabel = [item.assetType valueForKey:@"label"];
  if (!typeLabel) {
    typeLabel = @"None";
  }
  [self.assetTypeButton setTitle:typeLabel forState:UIControlStateNormal];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  
  [self.view endEditing:YES];
  
  item.itemName = self.nameField.text;
  item.serialNumber = self.serialNumberField.text;
  item.valueInDollars = [NSNumber numberWithInt:[self.valueField.text integerValue]];
}

- (void)setItem:(BNRItem *)it {
  item = it;
  self.navigationItem.title = item.itemName;
}

- (IBAction)takePicture:(id)sender {
  UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
  
  if ([imagePickerPopover isPopoverVisible]) {
    [imagePickerPopover dismissPopoverAnimated:YES];
    imagePickerPopover = nil;
    return;
  }
  
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
  } else {
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
  }
  
  imagePicker.delegate = self;
  
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    self.imagePickerPopover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
    self.imagePickerPopover.delegate = self;
    [self.imagePickerPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
  } else {
    [self presentViewController:imagePicker animated:YES completion:nil];
  }
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
  
  [item setThumbnailDataFromImage:image];
  
  CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
  CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
  
  NSString *key = (__bridge NSString*)newUniqueIDString;
  self.item.imageKey = key;
  
  [[BNRImageStore sharedStore] setImage:image forKey:key];
  
  CFRelease(newUniqueIDString);
  CFRelease(newUniqueId);
  
  self.imageView.image = image;
  
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    [self dismissViewControllerAnimated:YES completion:nil];
  } else {
    [self.imagePickerPopover dismissPopoverAnimated:YES];
    self.imagePickerPopover = nil;
  }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
  NSLog(@"User dismissed popover");
  imagePickerPopover = nil;
}

- (id)initForNewItem:(BOOL)isNew {
  self = [super initWithNibName:@"DetailViewController" bundle:nil];
  
  if (self) {
    if (isNew) {
      UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)];
      self.navigationItem.rightBarButtonItem = doneItem;
      
      UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
      self.navigationItem.leftBarButtonItem = cancelItem;
    }
  }
  
  return self;
}

-(void)save:(id)sender {
  [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

-(void)cancel:(id)sender {
  [[BNRItemStore sharedStore] removeItem:self.item];
  
  [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  @throw [NSException exceptionWithName:@"Wrong initializer" reason:@"User initForNewItem" userInfo:nil];
  return nil;
}

- (IBAction) showAssetTypePicker:(id)sender {
  [self.view endEditing:YES];
  
  AssetTypePicker *assetTypePicker = [[AssetTypePicker alloc] init];
  [assetTypePicker setItem:item];
  [self.navigationController pushViewController:assetTypePicker animated:YES];
}

@end
