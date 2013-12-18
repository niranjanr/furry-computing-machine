//
//  HypnosisView.m
//  Hypnosister
//
//  Created by Niranjan R on 12/18/13.
//  Copyright (c) 2013 Niranjan R. All rights reserved.
//

#import "HypnosisView.h"

@implementation HypnosisView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect bounds = self.bounds;
    
    
    CGPoint center;
    center.x = (bounds.origin.x + bounds.size.width) / 2;
    center.y = (bounds.origin.y + bounds.size.height) / 2;
    
    float maxRadius = hypot(center.x, center.y) / 2;
    
    CGContextSetLineWidth(ctx, 10);
    
    CGContextSetRGBStrokeColor(ctx, 0.6, 0.6, 0.6, 1.0);
    
    CGContextAddArc(ctx, center.x, center.y, maxRadius, 0, 2 * M_PI, YES);

    CGContextStrokePath(ctx);
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }

    return self;
}

@end
