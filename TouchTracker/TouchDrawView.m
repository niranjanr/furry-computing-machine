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

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(tap:)];
    [self addGestureRecognizer:tapGestureRecognizer];
  }

  return self;
}

- (void)tap:(UIGestureRecognizer *)gr {
  NSLog(@"recognized a tap");

  CGPoint tappedPoint = [gr locationInView:self];
  [self setSelectedLine:[self lineAtPoint:tappedPoint]];

  [self.linesInProcess removeAllObjects];

  if (self.selectedLine) {
    [self becomeFirstResponder];

    UIMenuController *menu = [UIMenuController sharedMenuController];
    UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(deleteLine:)];
    menu.menuItems = @[item];
    [menu setTargetRect:CGRectMake(tappedPoint.x, tappedPoint.y, 2, 2) inView:self];
    [menu setMenuVisible:YES animated:YES];
  } else {
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
  }

  [self setNeedsDisplay];
}

- (void)deleteLine:(id)sender {
  [self.completeLines removeObject:self.selectedLine];
  [self setNeedsDisplay];
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

  if (self.selectedLine) {
    [[UIColor greenColor] set];
    CGContextMoveToPoint(context, self.selectedLine.begin.x, self.selectedLine.begin.y);
    CGContextAddLineToPoint(context, self.selectedLine.end.x, self.selectedLine.end.y);
    CGContextStrokePath(context);
  }
}

- (BOOL)canBecomeFirstResponder {
  return YES;
}

- (Line *)lineAtPoint:(CGPoint)point {
  for (Line *line in self.completeLines) {
    CGPoint start = line.begin;
    CGPoint end = line.end;

    for (float t = 0; t < 1.0; t += 0.05) {
      float x = start.x + t * (end.x - start.x);
      float y = start.y + t * (end.y - start.y);

      // if the tapped point is within 20 points, then select it
      if (hypot(x - point.x, y - point.y) < 20) {
        return line;
      }
    }
  }
  return nil;
}

#pragma mark Touch Handling

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
