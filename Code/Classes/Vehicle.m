//
//  Vehicle.m
//  Traffic
//
//  Created by Jonathon Manning on 25/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Vehicle.h"
#import "Path.h"
#import "PathDrawer.h"
#import "TrafficController.h"

@implementation Vehicle

@synthesize image, speed, pathDrawer, desiredGoalTag, controller, slowed, goalLane;

- (id)initWithName:(NSString*)vehicleImageName goalTag:(NSInteger)tag {
	
	desiredGoalTag = tag;
	
	NSString* imageName;
	if (desiredGoalTag == 0)
		imageName = [vehicleImageName stringByAppendingString:@".png"];
	else 
		imageName = [vehicleImageName stringByAppendingString:@"-Blink.png"];
	
	UIImage* loadedImage = [UIImage imageNamed:imageName];
	
	
	CGRect rect = CGRectMake(0, 0, loadedImage.size.width, loadedImage.size.height);
	
	
	self = [super initWithFrame:rect];
	
	self.image = loadedImage;
	
	self.opaque = FALSE;
	self.backgroundColor = [UIColor clearColor];
	
	
	self.speed = 125;
	return self;
	
	
}


- (void)drawRect:(CGRect)rect {
    [image drawInRect:rect];
}

- (void)dealloc {
	[currentPath.pathDrawer.paths removeObject:currentPath];
	
	[currentPath release];

    [super dealloc];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"Began moving vehicle %@", self);
	
	UITouch* aTouch = [touches anyObject];
		
	slowed = YES;
	
	// delete our current path
	[currentPath.pathDrawer.paths removeObject:currentPath];
	[currentPath release]; 
	
	currentPath = [[Path alloc] initWithDrawer:pathDrawer];
	currentPath.owner = self;
	[currentPath retain];
	
	//if (slowed)
	//	[self toggleStopped];
	
	goalPoint = CGPointZero;
	
	// 
	
	//[currentPath pushPoint:goalPoint];
	
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch* aTouch = [touches anyObject];
	
	// does this touch intersect with a lane? ask the controller
	Lane* lane =  [controller laneAtPoint:[aTouch locationInView:self.superview]];
	
	if (lane) {		
		self.goalLane = lane;
	}
	
	if (CGPointEqualToPoint(goalPoint, CGPointZero)) {
		goalPoint = [aTouch locationInView:[self superview]];
	} else {
		[currentPath pushPoint:[aTouch locationInView:[self superview]]];
		//[currentPath setNeedsDisplay];
	}
	
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	//[currentPath setNeedsDisplay];
	
	slowed = NO;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	//[currentPath setNeedsDisplay];
	
	slowed = NO;
}



@end
