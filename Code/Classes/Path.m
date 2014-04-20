//
//  Path.m
//  Traffic
//
//  Created by Jonathon Manning on 25/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Path.h"
#import "Vehicle.h"
#import "PathDrawer.h"

@implementation Path
@synthesize owner, points, pathDrawer;


- (id)initWithDrawer:(PathDrawer*)d {
    if (self = [super init]) {
		[d.paths addObject:self];
		self.pathDrawer = d;
        points = [[NSMutableArray arrayWithCapacity:50] retain];
		
    }
    return self;
}

- (void)pushPoint:(CGPoint)point {
	[points addObject:[NSValue valueWithCGPoint:point]];
}

- (CGPoint)takePoint {
	CGPoint point = [[points objectAtIndex:0] CGPointValue];
	[points removeObjectAtIndex:0];
	//[self setNeedsDisplay];
	return point;
}


- (BOOL)hasPoints {
	return [points count] > 0;
}

- (void)dealloc {
	self.pathDrawer = nil;
	//[pathDrawer.paths removeObject:self];
    [super dealloc];
}


@end
