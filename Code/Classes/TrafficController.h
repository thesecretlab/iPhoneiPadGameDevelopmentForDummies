//
//  TrafficController.h
//  Traffic
//
//  Created by Jonathon Manning on 25/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Vehicle;
@class TrafficViewController;
@class PathDrawer;
@class Lane;

@interface TrafficController : NSObject {
	// arrays of the locations of each car manager
	NSMutableArray* lanes;
	NSMutableArray* vehicles;
	
	NSMutableArray* vehiclesToDestroy;
	
	NSTimer* gameTimer;
	
	TrafficViewController* viewController;
	
	PathDrawer* pathDrawer;
	
	BOOL paused;
	
	NSTimer* countdownTimer;
	
	CGFloat timeRemaining;
	CGFloat timeTotal;

}

@property (readonly) CGFloat timeTotal;

-(void)registerVehicle:(Vehicle*)vehicle;
-(void)registerLane:(Lane*)lane;

-(void) startCarFromLane:(Lane*)starter;

- (void)startGame;
- (void)togglePause;
- (void)stopGame;

-(Lane*)laneAtPoint:(CGPoint)point;


@property (nonatomic, retain) IBOutlet PathDrawer* pathDrawer;
@property (nonatomic,retain) IBOutlet TrafficViewController* viewController;
@property (assign) BOOL paused;

@end
