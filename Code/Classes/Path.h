//
//  Path.h
//  Traffic
//
//  Created by Jonathon Manning on 25/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Vehicle;
@class PathDrawer;

@interface Path : NSObject {
	NSMutableArray* points;
	Vehicle* owner;
	PathDrawer* pathDrawer;
}

@property (nonatomic, retain) Vehicle* owner;
@property (nonatomic, retain) NSMutableArray* points;
@property (nonatomic, retain) PathDrawer* pathDrawer;

- (id)initWithDrawer:(PathDrawer*)d;

- (void)pushPoint:(CGPoint)point;
- (BOOL)hasPoints;

- (CGPoint)takePoint;
	

@end
