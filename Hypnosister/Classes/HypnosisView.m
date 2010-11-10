//
//  HypnosisView.m
//  Hypnosister
//
//  Created by Stephan Eletzhofer on 09.11.10.
//  Copyright 2010 Nexiles GmbH. All rights reserved.
//

#import "HypnosisView.h"

#define DBGS   NSLog(@"%s start", __PRETTY_FUNCTION__)
#define DBG(x) NSLog(@"%s %s=%@", __PRETTY_FUNCTION__, #x, x)

@implementation HypnosisView


- (id)initWithFrame:(CGRect)frame
{
    DBGS;
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    DBGS;

    CGRect bounds = self.bounds;

    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width/2.0;
    center.y = bounds.origin.y + bounds.size.height/2.0;

    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;

    NSLog(@"center=%3.3f, %3.3f maxRadius=%3.3f", center.x, center.y, maxRadius);

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 10);
    [[UIColor lightGrayColor] setStroke];

    for (float r = maxRadius; r > 0.0; r -= 20.0) {
        NSLog(@"arc -> (%3.3f, %3.3f) r=%3.3f", center.x, center.y, r);
        CGContextAddArc(context, center.x, center.y,
                r, 0.0, M_PI*2.0, YES);
        CGContextStrokePath(context);

    }
}

- (void)dealloc
{
    DBGS;
    [super dealloc];
}


@end
// vim: set ts=4 sw=4 expandtab tw=78 : 
