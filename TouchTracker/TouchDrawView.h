//
//  TouchDrawView.h
//  TouchTracker
//
//  Created by Niranjan Ravichandran on 1/22/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Line.h"

@interface TouchDrawView : UIView

@property (nonatomic, strong) NSMutableDictionary *linesInProcess;
@property (nonatomic, strong) NSMutableArray *completeLines;
@property (nonatomic, weak) Line *selectedLine;

- (void) clearAll;
- (Line *)lineAtPoint:(CGPoint)point;

@end
