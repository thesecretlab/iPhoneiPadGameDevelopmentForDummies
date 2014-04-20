//
//  TrafficController.m
//  Traffic
//
//  Created by Jonathon Manning on 25/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TrafficController.h"
#import "TrafficViewController.h"
#import "Vehicle.h"
#import "Lane.h"
#import "TrafficAppDelegate.h"

@implementation TrafficController

@synthesize viewController;
@synthesize pathDrawer;
@synthesize paused;
@synthesize timeTotal;

#define TIME_TICK 1.0/30.0

#define GOAL_THRESHOLD 15*15

- (id) init
{
	self = [super init];
	if (self != nil) {
		
	}
	return self;
}

- (void)awakeFromNib {
	lanes = [[NSMutableArray arrayWithCapacity:5] retain];
	
	vehicles = [[NSMutableArray arrayWithCapacity:10] retain];
	vehiclesToDestroy = [[NSMutableArray arrayWithCapacity:10] retain];
	
	countdownTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(decrementTime:) userInfo:nil repeats:YES];
	
	timeRemaining = 15.0;
				 
}

- (void)decrementTime:(NSTimer*)timer {
	timeRemaining -= 0.1;
	timeTotal += 0.1;
	
	[viewController setTimeRemaining:timeRemaining];
	
	if (timeRemaining < 0) {
		// game over!
		[viewController displayGameOver];
		[self stopGame];
		
	}
		
	
}

#define TURN_SPEED 1

-(void)update {
	for (Vehicle* v in vehicles) {
		// move it!
		
		CGPoint position = v.center;
		
		CGFloat speed = v.speed + timeTotal * 5;
		CGFloat lateralSpeed = 200;//v.lateralSpeed;
		
		if (v.slowed) {
			speed *= 0.5;
			//lateralSpeed *= 0.5;
		}
		
		CGPoint goalLanePosition = v.goalLane.center;
		
		CGFloat deltaX = fabs(goalLanePosition.x - position.x);
		if (deltaX < 3)
			position.x = goalLanePosition.x;
		
		if (position.x > goalLanePosition.x)
			position.x -= lateralSpeed * TIME_TICK;
		else if (position.x < goalLanePosition.x)
			position.x += lateralSpeed * TIME_TICK;

		
		position.y -= speed * TIME_TICK;
		
		v.center = position;
		
		if (position.y < -50) {
			[self vehicleReachedEndOfRoad:v];
		}
		
		// are we colliding with any other vehicles?
		for (Vehicle* otherVehicle in vehicles) {
			
			if (otherVehicle == v) continue;
			
			CGRect myRect = CGRectInset(v.frame, 7,7);
			CGRect otherRect = CGRectInset(otherVehicle.frame, 7, 7);
			
			if (CGRectIntersectsRect(myRect, otherRect)) {
				[self vehicle:v collidedWithVehicle: otherVehicle];
				return; // the game ends after this
			}
		}
				
		
		
		
	}
	
	for (Vehicle* v in vehiclesToDestroy) {
		
		[vehicles removeObject:v];
	}
	
	[pathDrawer setNeedsDisplay];
	
}

- (void)startGame {
	gameTimer = [[NSTimer scheduledTimerWithTimeInterval:TIME_TICK target:self selector:@selector(update) userInfo:nil repeats:YES] retain];
	
	
}


- (void) vehicle:(Vehicle*) aVehicle collidedWithVehicle: (Vehicle*) otherVehicle {
	// game over, man
	
	[viewController displayGameOver];
	
	[self stopGame];
}

- (void)vehicleReachedEndOfRoad:(Vehicle*)v {
	[v removeFromSuperview];
	[vehiclesToDestroy addObject:v];
	
	if (v.goalLane.tag == v.desiredGoalTag)
		timeRemaining += 1.5;
}

- (void)stopGame {
	
	[countdownTimer invalidate];
	[gameTimer invalidate];
	
	for (Lane* l in lanes) {
		[l stop];
	}
	[lanes removeAllObjects];
	
	[vehicles removeAllObjects];
	
	
	// inform the app delegate about the score
	TrafficAppDelegate* delegate = (TrafficAppDelegate*)[[UIApplication sharedApplication] delegate];
	//[delegate addHighScore:score];
}

- (void)togglePause {
	paused = !paused;
	
	
	if (paused) {
		
		
		[gameTimer invalidate];
		[gameTimer release];
		
		// make all vehicles not respond to user interaction
		for (Vehicle* v in vehicles) {
			v.userInteractionEnabled = NO;
		}
		
	} else {
		
		gameTimer = [[NSTimer scheduledTimerWithTimeInterval:TIME_TICK target:self selector:@selector(update) userInfo:nil repeats:YES] retain];
		
		// make all vehicles  respond to user interaction
		for (Vehicle* v in vehicles) {
			v.userInteractionEnabled = YES;
		}
	}
}

- (void)startCarFromLane:(Lane *)lane {
	// create a new car from the designated starter's position
	
	NSLog(@"Starting new car");
	
	NSString* carType;
	
	int type = random() % 3;
	
	switch (type) {
		case 0:
			carType = @"GreenCar";
			break;
		case 1:
			carType = @"RedCar";
			break;
		case 2:
			carType = @"BlueCar";
			break;
	}
	
	Vehicle* v = [[Vehicle alloc] initWithName:carType goalTag:type];
	[viewController.view addSubview:v];
	
	
	[self registerVehicle:v];
	
	[v setController:self];
	[v setPathDrawer:pathDrawer];
	[v setGoalLane:lane];
	
	CGPoint position = [lane center];
	position.y = 480;
	[v setCenter:position];
	
	
	[v release];
	
}

-(Lane*)laneAtPoint:(CGPoint)point {
	for (Lane* lane in lanes) {
		if (CGRectContainsPoint([lane frame], point))
			return lane;
	}
	return nil;
}

-(void)registerLane:(Lane*)lane {
	[lanes addObject:lane];
}

-(void)registerVehicle:(Vehicle*)vehicle {
	[vehicles addObject:vehicle];
	//NSLog(@"Registered %@", vehicle);
}

@end
