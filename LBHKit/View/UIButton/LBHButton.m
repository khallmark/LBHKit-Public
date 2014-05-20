//
//  LBHButton.m
//  LBHKit
//
//  Created by Kevin Hallmark on 10/31/13.
//  Copyright (c) 2013 Little Black Hat. All rights reserved.
//

#import "LBHButton.h"

@implementation LBHButton

-(void)awakeFromNib
{

	[self addObserver:self forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
	
	if (self.selected == YES)
	{
		CGContextRef ctx = UIGraphicsGetCurrentContext();
		
		CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
		
		const CGFloat *topGradientColorComponents = CGColorGetComponents([UIColor whiteColor].CGColor);
		const CGFloat *bottomGradientColorComponents = CGColorGetComponents([UIColor blackColor].CGColor);
		
		CGFloat colors[] =
		{
			topGradientColorComponents[0], topGradientColorComponents[1], topGradientColorComponents[2], topGradientColorComponents[3],
			bottomGradientColorComponents[0], bottomGradientColorComponents[1], bottomGradientColorComponents[2], bottomGradientColorComponents[3]
		};
		CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors) / (sizeof(colors[0]) * 4));
		CGColorSpaceRelease(rgb);
		
		CGContextDrawLinearGradient(ctx, gradient, CGPointMake(0, 0), CGPointMake(0, self.bounds.size.height), 0);
		CGGradientRelease(gradient);
	}
	else
	{
		// Do custom drawing for normal state
	}
}

- (void)dealloc
{
	[self removeObserver:self forKeyPath:@"highlighted"];
	
//	[super dealloc];
}

@end
