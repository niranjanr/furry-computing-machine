//
//  ItemsViewController.m
//  Homepwner
//
//  Created by Niranjan Ravichandran on 12/20/13.
//  Copyright (c) 2013 Niranjan Ravichandran. All rights reserved.
//

#import "ItemsViewController.h"
#import "BNRItem.h"
#import "BNRItemStore.h"
#import "DetailViewController.h"
#import "HomepwnerItemCell.h"
#import "BNRImageStore.h"
#import "ImageViewController.h"

NSString *ITEM_REUSE_IDENTIFIER = @"UITableViewCell1";

@implementation ItemsViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        UINavigationItem *n = self.navigationItem;
        n.title = @"Homepwner";
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        self.navigationItem.rightBarButtonItem = bbi;
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem;

        // create 5 items in the item store
        for (int i = 0; i < 5; i++) {
            [[BNRItemStore sharedStore] createItem];
        }
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UINib *nib = [UINib nibWithNibName:@"HomepwnerItemCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"HomepwnerItemCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[BNRItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    BNRItem *item = [[[BNRItemStore sharedStore] allItems] objectAtIndex:indexPath.row];

    HomepwnerItemCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"HomepwnerItemCell"];
    cell.titleLabel.text = item.itemName;
    cell.serialNumberLabel.text = item.serialNumber;
    cell.thumbnailView.image = item.thumbnail;
    cell.valueLabel.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    cell.tableView = self.tableView;
    cell.controller = self;

    return cell;
}

#pragma mark

- (IBAction)addNewItem:(id)sender {
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];

    DetailViewController *dtvc = [[DetailViewController alloc] initForNewItem:YES];
    dtvc.item = newItem;

    dtvc.dismissBlock = ^{
        [self.tableView reloadData];
    };

    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:dtvc];
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    navController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        // delete the item from the backing store
        BNRItemStore *store = [BNRItemStore sharedStore];
        NSMutableArray *items = [store allItems];
        BNRItem *itemToDelete = [items objectAtIndex:indexPath.row];
        [store removeItem:itemToDelete];

        // delete the row from the table
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *dtvc = [[DetailViewController alloc] initForNewItem:NO];

    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *selectedItem = [items objectAtIndex:indexPath.row];
    dtvc.item = selectedItem;

    [self.navigationController pushViewController:dtvc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return toInterfaceOrientation == UIInterfaceOrientationPortrait;
    }
}

- (void)showImage:(id)sender atIndexPath:(NSIndexPath *)ip {
  NSLog(@"Going to show the image for %@", ip);

  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    BNRItem *item = [[[BNRItemStore sharedStore] allItems] objectAtIndex:[ip row]];
    NSString *imageKey = item.imageKey;

    UIImage *img = [[BNRImageStore sharedStore] imageForKey:imageKey];

    // bail if there is no valid image
    if (!img) {
      return;
    }

    CGRect rect = [self.view convertRect:[sender bounds] fromView:sender];
    ImageViewController *ivc = [[ImageViewController alloc] init];
    ivc.image = img;
    self.imagePopover = [[UIPopoverController alloc] initWithContentViewController:ivc];
    self.imagePopover.delegate = self;
    self.imagePopover.popoverContentSize = CGSizeMake(600, 600);
    [self.imagePopover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
  }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
  [self.imagePopover dismissPopoverAnimated:YES];
  self.imagePopover = nil;
}
@end
