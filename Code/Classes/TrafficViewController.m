//
//  CarsViewController.m
//  Cars
//
//  Created by Jonathon Manning on 25/10/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "TrafficViewController.h"
#import "TrafficAppDelegate.h"
#import "TrafficController.h"
#import "Vehicle.h"

@implementation TrafficViewController

@synthesize overlayButton;
@synthesize endButton;
@synthesize gameController;
@synthesize timeRemainingLabel;
@synthesize gameOverOverlay;
@synthesize pauseOverlay;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
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
	[super viewWillAppear:animated];
	[gameController startGame];
	
	
	//[[UIApplication sharedApplication] setStatusBarHidden:YES animated:animated];
	
	
}

- (void)viewWillDisappear:(BOOL)animated {
	//[gameController stopGame];
	[super viewWillDisappear:animated];
	//[[UIApplication sharedApplication] setStatusBarHidden:NO animated:animated];
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

-(void)displayGameOver {
	
	[self.view addSubview:gameOverOverlay];
	
	// Wait 1.5 seconds and go to the main screen
	[self performSelector:@selector(endGame:) withObject:nil afterDelay:1.5];
	
}

-(IBAction) pauseGame:(id)sender {
	
	[gameController togglePause];
	if ([gameController paused]) {
		[self.view addSubview:pauseOverlay];
	} else {
		[pauseOverlay removeFromSuperview];
	}
	
	//
}

- (IBAction) endGame:(id)sender {
	
	//[gameController stopGame];
	
	[self.navigationController popViewControllerAnimated:NO];
	
	//TrafficAppDelegate* delegate;
	//delegate = (TrafficAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	//[delegate endGame];
}

- (void)setTimeRemaining:(CGFloat)time {
	timeRemainingLabel.text = [NSString stringWithFormat:@"%.1f", time];
}

@end
