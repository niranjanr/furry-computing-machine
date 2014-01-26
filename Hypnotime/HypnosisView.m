//
//  HypnosisView.m
//  Hypnosister
//
//  Created by Niranjan R on 12/18/13.
//  Copyright (c) 2013 Niranjan R. All rights reserved.
//

#import "HypnosisView.h"

@implementation HypnosisView

@synthesize circleColor;

-(void) setCircleColor:(UIColor *)color {
    circleColor = color;
    [self setNeedsDisplay];
}

#pragma mark UIView methods

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect bounds = self.bounds;
    
    
    CGPoint center;
    center.x = (bounds.origin.x + bounds.size.width) / 2;
    center.y = (bounds.origin.y + bounds.size.height) / 2;
    
    
    CGContextSetLineWidth(ctx, 1);
    
    [self.circleColor setStroke];
    
    float maxRadius = hypot(center.x, center.y);
    for (float currentRadius = maxRadius;
         currentRadius > 0; currentRadius -= 20) {

        CGContextAddArc(ctx, center.x, center.y, currentRadius, 0, 2 * M_PI, YES);
        CGContextStrokePath(ctx);
    }

    NSString *sleepyString = @"You are getting sleepy!";
    UIFont *font = [UIFont boldSystemFontOfSize:20];
    CGRect textRect;
    textRect.size = [sleepyString sizeWithFont:font];
    textRect.origin.x = center.x - (textRect.size.width / 2);
    textRect.origin.y = center.y - (textRect.size.height / 2);
    [[UIColor blackColor] setFill];
    CGSize offset = CGSizeMake(4, 3);
    CGColorRef color = [[UIColor darkGrayColor] CGColor];CGContextSetShadowWithColor(ctx, offset, 2.0, color);
    [sleepyString drawInRect:textRect withFont:font];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor grayColor];
        self.boxLayer = [[CALayer alloc] init];
        self.boxLayer.bounds = CGRectMake(0, 0, 85, 85);
        self.boxLayer.position = CGPointMake(160, 100);

        // set the color of the layer to be reddish
        UIColor *reddish = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
        CGColorRef cgRefReddish = [reddish CGColor];
        self.boxLayer.backgroundColor = cgRefReddish;

        UIImage *layerImage = [UIImage imageNamed:@"Hypno.png"];
        CGImageRef layerImageRef = [layerImage CGImage];
        [self.boxLayer setContents:(__bridge id)layerImageRef];
        self.boxLayer.contentsRect = CGRectMake(-0.1, -0.1, 1.2, 1.2);
        self.boxLayer.contentsGravity = kCAGravityResizeAspect;

        // add the layer to the layer hierarchy
        [self.layer addSublayer:self.boxLayer];
    }

    return self;
}

#pragma mark UIResponder methods

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"Device started shaking");
        self.circleColor = [UIColor redColor];
    }
}


@end
