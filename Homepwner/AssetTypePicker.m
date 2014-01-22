//
//  AssetTypePicker.m
//  Homepwner
//
//  Created by Niranjan Ravichandran on 1/21/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import "AssetTypePicker.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@implementation AssetTypePicker

@synthesize item;

- (id)init {
  return [super initWithStyle:UITableViewStyleGrouped];
}

- (id)initWithStyle:(UITableViewStyle)style {
  return [super initWithStyle:UITableViewStyleGrouped];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[[BNRItemStore sharedStore] allAssetTypes] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
  
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
  }
  
  NSArray *allAssets = [[BNRItemStore sharedStore] allAssetTypes];
  NSManagedObject *assetType = [allAssets objectAtIndex:indexPath.row];
  
  NSString *assetLabel = [assetType valueForKey:@"label"];
  cell.textLabel.text = assetLabel;
  
  if (assetType == item.assetType) {
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
  } else {
    cell.accessoryType = UITableViewCellAccessoryNone;
  }
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  
  cell.accessoryType = UITableViewCellAccessoryCheckmark;
  
  NSArray *allAssets = [[BNRItemStore sharedStore] allAssetTypes];
  NSManagedObject *assetType = [allAssets objectAtIndex:indexPath.row];
  [item setAssetType:assetType];
  [self.navigationController popViewControllerAnimated:YES];
}
@end
