//
//  Lane.m
//  Traffic
//
//  Created by Jonathon Manning on 4/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Lane.h"
#import "TrafficController.h"

@implementation Lane

@synthesize controller;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}

- (void) awakeFromNib {
	[controller registerLane:self];
	srandom(time(NULL));
	long newStartTime = random() % 200;
	carStartTimer = [NSTimer scheduledTimerWithTimeInterval:newStartTime / 1000.0 target:self selector:@selector(startTimerFired:) userInfo:nil repeats:YES];
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (void)startTimerFired:(NSTimer*)timer {
	// pick a random number of milliseconds to fire again at
	
	
	
	long newStartTime = random() % 500 + (3000 - controller.timeTotal * 10);
	
	[timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:newStartTime / 1000.0]];
	
	[controller startCarFromLane:self];
	
	NSLog(@"Starting new car");
}

-(void)stop {
	[carStartTimer invalidate];
}

- (void)dealloc {
    [super dealloc];
}


@end
