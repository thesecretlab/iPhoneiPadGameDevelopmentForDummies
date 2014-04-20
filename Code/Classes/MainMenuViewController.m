//
//  MainMenuViewController.m
//  Traffic
//
//  Created by Jonathon Manning on 25/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MainMenuViewController.h"
#import "TrafficAppDelegate.h"
#import "TrafficViewController.h"
#import "StatsViewController.h"
#import "SettingsViewController.h"

@implementation MainMenuViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
	
	popAnimation.keyTimes = [NSArray arrayWithObjects:
							 [NSNumber numberWithFloat:0.0], 
							 [NSNumber numberWithFloat:0.7], 
							 [NSNumber numberWithFloat:1.0], nil];
	
	popAnimation.values = [NSArray arrayWithObjects:
							[NSNumber numberWithFloat:0.01],
							 [NSNumber numberWithFloat:1.1],
						   [NSNumber numberWithFloat:1.0], nil];
	
	[popAnimation retain];
}


- (void)viewWillAppear:(BOOL)animated {
	[popAnimation setDuration:0.3];
	
	[newGameButton setHidden:YES];
	[statsButton setHidden:YES];
	[settingsButton setHidden:YES];
	
	
	
	[self performSelector:@selector(popView:) withObject:newGameButton afterDelay:0.25];
	[self performSelector:@selector(popView:) withObject:statsButton afterDelay:0.3];
	[self performSelector:@selector(popView:) withObject:settingsButton afterDelay:0.35];
	
}

- (void)popView:(UIView*)view {
	[view setHidden:NO];
	[[view layer] addAnimation:popAnimation forKey:@"transform.scale"];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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

-(IBAction) newGame:(id)sender {
	//TrafficAppDelegate* delegate;
	//delegate = (TrafficAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	TrafficViewController* traffic = [[TrafficViewController alloc] initWithNibName:@"TrafficViewController" bundle:nil];
	
	[self.navigationController pushViewController:traffic animated:NO];
	
	//[delegate newGame];
}

-(IBAction) showStats:(id)sender {
	StatsViewController* stats = [[StatsViewController alloc] initWithNibName:@"StatsViewController" bundle:nil];
	[self.navigationController pushViewController:stats animated:NO];
}

-(IBAction) showSettings:(id)sender {
	SettingsViewController* settings = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
	[self.navigationController pushViewController:settings animated:NO];
}

@end
