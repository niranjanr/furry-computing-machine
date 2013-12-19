//
//  HypnosisterAppDelegate.h
//  Hypnosister
//
//  Created by Niranjan R on 12/18/13.
//  Copyright (c) 2013 Niranjan R. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HypnosisView.h"

@interface HypnosisterAppDelegate : UIResponder <UIApplicationDelegate, UIScrollViewDelegate> {
    HypnosisView *view;
}

@property (strong, nonatomic) UIWindow *window;

@end
