//
//  CarsAppDelegate.m
//  Cars
//
//  Created by Jonathon Manning on 25/10/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "TrafficAppDelegate.h"
#import "TrafficViewController.h"
#import "MainMenuViewController.h"
#import "StatsViewController.h"
#import "SettingsViewController.h"

@implementation TrafficAppDelegate

@synthesize window;
@synthesize gameViewController;
@synthesize mainMenu;
@synthesize statsViewController;
@synthesize settingsViewController;

@synthesize shouldPlayMusic;
@synthesize shouldPlaySFX;
@synthesize audioSourceIsIPodLibrary;

@synthesize navigationController;
@synthesize scoresList;

@synthesize iPodPlayer;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
	
	[window addSubview:navigationController.view];
	
	//[window addSubview:mainMenu.view];
	
    [window makeKeyAndVisible];
	
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
	
	// Load the high scores list
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	scoresListPath = [documentsDirectory stringByAppendingPathComponent:@"scores.plist"];
	[scoresListPath retain];
	
	scoresList = [[NSMutableArray arrayWithContentsOfFile:scoresListPath] retain];
	
	if (scoresList == nil) {
		scoresList = [[NSMutableArray array] retain];
	}
	
	NSURL* musicURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"MusicTrack" ofType:@"mp3"]];
	NSError* error;
	
	musicPlayer = [AVAudioPlayer alloc];
	[musicPlayer initWithContentsOfURL:musicURL error:&error];
	musicPlayer.numberOfLoops = -1; // loop forever
	[musicPlayer retain];
	
	NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
								[NSNumber numberWithBool:TRUE], @"shouldPlayMusic",
								[NSNumber numberWithBool:TRUE], @"shouldPlaySFX",
								[NSNumber numberWithBool:FALSE], @"audioSourceIsIPodLibrary",
								nil]];
	
	self.shouldPlayMusic = [defaults boolForKey:@"shouldPlayMusic"];
	self.shouldPlaySFX = [defaults boolForKey:@"shouldPlaySFX"];
	self.audioSourceIsIPodLibrary = [defaults boolForKey:@"audioSourceIsIPodLibrary"];
	
	
	iPodPlayer = [MPMusicPlayerController iPodMusicPlayer];
	
	[iPodPlayer setShuffleMode: MPMusicShuffleModeOff];
	[iPodPlayer setRepeatMode: MPMusicRepeatModeNone];
	
	 
	[iPodPlayer beginGeneratingPlaybackNotifications];
	
	[iPodPlayer retain];
	
	
}



- (void)applicationWillTerminate:(UIApplication *)application {
	// save our settings
	NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setBool:shouldPlayMusic forKey:@"shouldPlayMusic"];
	[defaults setBool:shouldPlaySFX forKey:@"shouldPlaySFX"];
	[defaults setBool:audioSourceIsIPodLibrary forKey:@"audioSourceIsIPodLibrary"];
	
}

-(void)setShouldPlayMusic:(BOOL)play {
	shouldPlayMusic = play;
	
	// start playing from the internal track if we're set to play music AND we're not set
	// to use the iPod
	
	if (play && audioSourceIsIPodLibrary == FALSE) {
		if (![musicPlayer isPlaying]) [musicPlayer play];
	} else {
		if ([musicPlayer isPlaying]) [musicPlayer stop];
	}
		
}


- (void)dealloc {

	
	[iPodPlayer endGeneratingPlaybackNotifications];
	[iPodPlayer release];
	[musicPlayer release];
	
    [gameViewController release];
    [window release];
    [super dealloc];
}

-(void) newGame {
	[mainMenu.view removeFromSuperview];
	[window addSubview:gameViewController.view];
}

-(void) endGame {
	[self.navigationController popToRootViewControllerAnimated:NO];
}

NSInteger intSort(id num1, id num2, void *context)
{
    int v1 = [num1 intValue];
    int v2 = [num2 intValue];
    if (v1 > v2)
        return NSOrderedAscending;
    else if (v1 < v2)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}

-(void)addHighScore:(NSInteger)score {
	
	[scoresList addObject:[NSNumber numberWithInt:score]];
	
	[scoresList sortUsingFunction:intSort context:nil];
	
	// write it out
	[scoresList writeToFile:scoresListPath atomically:YES];
	
}




@end
