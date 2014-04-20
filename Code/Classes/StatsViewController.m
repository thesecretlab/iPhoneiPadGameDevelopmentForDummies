//
//  StatsViewController.m
//  Traffic
//
//  Created by Jonathon Manning on 1/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "StatsViewController.h"
#import "TrafficAppDelegate.h"

@implementation StatsViewController

@synthesize score1, score2, score3, score4;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
}


- (void)viewWillAppear:(BOOL)animated {
	
	TrafficAppDelegate* delegate;
	delegate = (TrafficAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	
	NSArray* labels = [NSArray arrayWithObjects:score1, score2, score3, score4, nil];
	
	for (int i = 0; i < 4 && i < [[delegate scoresList] count]; i++) {
		UILabel* label = (UILabel*)[labels objectAtIndex:i];
		label.text = [NSString stringWithFormat:@"%i", [[[delegate scoresList] objectAtIndex:i] intValue]];
		
	}
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (IBAction) goBack:(id)sender {
	[self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
