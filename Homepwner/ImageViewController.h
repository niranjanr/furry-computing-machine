//
//  ImageViewController.h
//  Homepwner
//
//  Created by Niranjan Ravichandran on 1/16/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *image;

@end
