//
//  HypnosisViewController.m
//  Hypnotime
//
//  Created by Niranjan R on 12/18/13.
//  Copyright (c) 2013 Niranjan R. All rights reserved.
//

#import "HypnosisViewController.h"
#import "HypnosisView.h"

@implementation HypnosisViewController

- (void)loadView {
    CGRect frame = [[UIScreen mainScreen] bounds];
    HypnosisView *v = [[HypnosisView alloc] initWithFrame:frame];
    self.view = v;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nil bundle:nil];

    if (self) {
        UITabBarItem *item = self.tabBarItem;
        item.title = @"Hypnosis";

        UIImage *image = [UIImage imageNamed:@"Hypno.png"];
        item.image = image;
    }

    return self;
}
@end
