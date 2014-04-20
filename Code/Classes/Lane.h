//
//  Lane.h
//  Traffic
//
//  Created by Jonathon Manning on 4/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TrafficController;

@interface Lane : UIView {
	NSTimer* carStartTimer;
	TrafficController* controller;
}

@property (nonatomic, retain) IBOutlet TrafficController* controller;

-(void)stop;

@end
