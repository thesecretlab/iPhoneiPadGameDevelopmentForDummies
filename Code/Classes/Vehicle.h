//
//  Vehicle.h
//  Traffic
//
//  Created by Jonathon Manning on 25/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Path;
@class PathDrawer;
@class TrafficController;
@class Lane;

@interface Vehicle : UIView {
	CGFloat speed;
	
	BOOL slowed;
	
	UIImage* image;
	
	
	Path* currentPath;
	
	CGPoint goalPoint;
	
	NSInteger desiredGoalTag;
	
	PathDrawer* pathDrawer;
	
	TrafficController* controller;
	
	CGFloat tapTime;
	
	Lane* goalLane;
	
}

- (id)initWithName:(NSString*)vehicleImageName goalTag:(NSInteger)tag;

@property (assign) CGFloat speed;
@property (assign) NSInteger desiredGoalTag;
@property (readonly) BOOL slowed;
@property (nonatomic, retain) Lane* goalLane;

@property (nonatomic, retain) TrafficController* controller;

@property (nonatomic, retain) UIImage* image;
@property (nonatomic, retain) PathDrawer* pathDrawer;

@end

