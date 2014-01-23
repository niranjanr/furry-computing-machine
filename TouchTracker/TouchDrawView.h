//
//  TouchDrawView.h
//  TouchTracker
//
//  Created by Niranjan Ravichandran on 1/22/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TouchDrawView : UIView

@property (nonatomic, strong) NSDictionary *linesInProcess;
@property (nonatomic, strong) NSMutableArray *completeLines;

- (void) clearAll;

@end
