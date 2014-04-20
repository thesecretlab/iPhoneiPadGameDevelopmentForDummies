//
//  PathDrawer.m
//  Traffic
//
//  Created by Jonathon Manning on 1/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PathDrawer.h"
#import "Path.h"

@implementation PathDrawer
@synthesize paths;

- (void)awakeFromNib {
	paths = [NSMutableArray arrayWithCapacity:10];
	[paths retain];
	self.opaque = FALSE;
	self.backgroundColor = [UIColor clearColor];
	self.userInteractionEnabled = FALSE;
}


- (void)drawRect:(CGRect)rect {
	
	if ([paths count] == 0) {
		return;
	}
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSetLineCap(context, kCGLineCapRound);
	CGContextSetLineWidth(context, 2.0);
	CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 0.6);
	
	for (Path* path in paths) {
		if (![path hasPoints]) continue;
		
		CGPoint firstPoint = [path.owner center];//
		//CGPoint firstPoint = [[[path points] objectAtIndex:0] CGPointValue];
		
		CGContextBeginPath(context);
		
		CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
		
		for (NSValue* p in [path points]) {
			CGPoint point = [p CGPointValue];
			
			CGContextAddLineToPoint(context, point.x, point.y);
		}
		
		CGContextStrokePath(context);
	}
	
	
}


- (void)dealloc {
    [super dealloc];
	[paths release];
}


@end
