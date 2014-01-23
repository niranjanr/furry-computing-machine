//
//  TouchDrawView.m
//  TouchTracker
//
//  Created by Niranjan Ravichandran on 1/22/14.
//  Copyright (c) 2014 Niranjan Ravichandran. All rights reserved.
//

#import "TouchDrawView.h"
#import "Line.h"

@implementation TouchDrawView

- (void) clearAll {
  [self.linesInProcess removeAllObjects];
  [self.completeLines removeAllObjects];

  [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];

  if (self) {
    self.linesInProcess = [[NSMutableDictionary alloc] init];
    self.completeLines = [[NSMutableArray alloc] init];
    self.backgroundColor = [UIColor whiteColor];
    self.multipleTouchEnabled = YES;
  }

  return self;
}

- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetLineWidth(context, 10.0);
  CGContextSetLineCap(context, kCGLineCapRound);

  [[UIColor blackColor] set];

  for(Line *line in self.completeLines) {
    CGContextMoveToPoint(context, line.begin.x, line.begin.y);
    CGContextAddLineToPoint(context, line.end.x, line.end.y);
    CGContextStrokePath(context);
  }

  [[UIColor redColor] set];
  for(NSValue *v in self.linesInProcess) {
    Line *line = [self.linesInProcess objectForKey:v];
    CGContextMoveToPoint(context, line.begin.x, line.begin.y);
    CGContextAddLineToPoint(context, line.end.x, line.end.y);
    CGContextStrokePath(context);
  }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  for (UITouch *touch in touches) {
    if ([touch tapCount] > 1) {
      [self clearAll];
      return;
    }

    NSValue *key = [NSValue valueWithNonretainedObject:touch];
    CGPoint loc = [touch locationInView:self];
    Line *newLine = [[Line alloc] init];
    newLine.begin = loc;
    newLine.end = loc;
    [self.linesInProcess setObject:newLine forKey:key];
  }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  for(UITouch *touch in touches) {
    NSValue *key = [NSValue valueWithNonretainedObject:touch];
    Line *line = [self.linesInProcess objectForKey:key];
    CGPoint loc = [touch locationInView:self];
    line.end = loc;
  }

  [self setNeedsDisplay];
}

- (void)endTouches:(NSSet *)touches withEvent:(UIEvent *)event {
  for(UITouch *touch in touches) {
    NSValue *key = [NSValue valueWithNonretainedObject:touch];
    Line *line = [self.linesInProcess objectForKey:key];
    if (line) {
      [self.completeLines addObject:line];
      [self.linesInProcess removeObjectForKey:key];
    }
  }

  [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [self endTouches:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
  [self endTouches:touches withEvent:event];
}

@end
