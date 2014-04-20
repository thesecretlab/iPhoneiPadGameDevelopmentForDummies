//
//  SettingsViewController.m
//  Traffic
//
//  Created by Jonathon Manning on 1/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "TrafficAppDelegate.h"

@implementation SettingsViewController

@synthesize musicSwitch, sfxSwitch, iPodControls, nowPlaying, playPauseButton, audioSource;

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
	
	TrafficAppDelegate* delegate;
	delegate = (TrafficAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	MPMusicPlayerController* player = delegate.iPodPlayer;
	
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	
	[notificationCenter
	 addObserver: self
	 selector:    @selector (handleNowPlayingItemChanged:)
	 name:        MPMusicPlayerControllerNowPlayingItemDidChangeNotification
	 object:      player];
	
	[notificationCenter
	 addObserver: self
	 selector:    @selector (handlePlaybackStateChanged:)
	 name:        MPMusicPlayerControllerPlaybackStateDidChangeNotification
	 object:      player];
}

-(void)handleNowPlayingItemChanged:(NSNotification*)notification {
	[nowPlaying setText:[[[notification object] nowPlayingItem] valueForProperty:MPMediaItemPropertyTitle]];
	
}

-(void)handlePlaybackStateChanged:(NSNotification*)notification {
	
	MPMusicPlayerController* player = [notification object];
	
	MPMusicPlaybackState state = player.playbackState;
	
	
	if (state == MPMusicPlaybackStatePaused ||
		state == MPMusicPlaybackStateStopped) {
		[playPauseButton setTitle:@"Play" forState:UIControlStateNormal];
	}
	
	if (state == MPMusicPlaybackStatePlaying) {
		[playPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
		
		// set the switch to the 'iPod' mode
		audioSource.selectedSegmentIndex = 1;
	}
}

- (IBAction) changedAudioSource:(id)sender {
	TrafficAppDelegate* delegate;
	delegate = (TrafficAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	delegate.audioSourceIsIPodLibrary = [sender selectedSegmentIndex] == 1;
	
	if (!delegate.audioSourceIsIPodLibrary && [delegate.iPodPlayer playbackState] == MPMusicPlaybackStatePlaying)
		[delegate.iPodPlayer pause];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)viewWillAppear:(BOOL)animated {
	TrafficAppDelegate* delegate;
	delegate = (TrafficAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	[musicSwitch setOn:delegate.shouldPlayMusic];
	[sfxSwitch setOn:delegate.shouldPlaySFX];
	
	if (delegate.shouldPlayMusic == NO)
		[iPodControls setAlpha:0.0];
	
	if (delegate.audioSourceIsIPodLibrary == YES)
		[audioSource setSelectedSegmentIndex:1];
	
	MPMediaItem* currentItem = [delegate.iPodPlayer nowPlayingItem];
	if (currentItem != nil)
		[nowPlaying setText:[currentItem valueForProperty:MPMediaItemPropertyTitle]];
	
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
	
	TrafficAppDelegate* delegate;
	delegate = (TrafficAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	MPMusicPlayerController* player = delegate.iPodPlayer;
	
	
	[[NSNotificationCenter defaultCenter]
	 removeObserver: self
	 name:           MPMusicPlayerControllerNowPlayingItemDidChangeNotification
	 object:         player];
	
	[[NSNotificationCenter defaultCenter]
	 removeObserver: self
	 name:           MPMusicPlayerControllerPlaybackStateDidChangeNotification
	 object:         player];
	
    [super dealloc];
}

- (IBAction) goBack:(id)sender {
	[self.navigationController popViewControllerAnimated:NO];
}

- (IBAction) changedMusicSetting:(id)sender {
	
	
	TrafficAppDelegate* delegate;
	delegate = (TrafficAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	delegate.shouldPlayMusic = [sender isOn];
	
	[UIView beginAnimations:@"FadeAnimation" context:nil];
	iPodControls.alpha = ([sender isOn] ? 1.0 : 0.0);
	[UIView commitAnimations];
	
	
}

- (IBAction) changedSFXSetting:(id)sender {
	TrafficAppDelegate* delegate;
	delegate = (TrafficAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	delegate.shouldPlaySFX = [sender isOn];
}

-(IBAction) openMusicPicker:(id)sender {
	MPMediaPickerController *picker =
    [[MPMediaPickerController alloc]
        initWithMediaTypes: MPMediaTypeAnyAudio];                   

	[picker setDelegate: self];                                         
	[picker setAllowsPickingMultipleItems: YES];                        
	picker.prompt = @"Select items to play";
	 
	[self presentModalViewController: picker animated: YES];    
	[picker release];
}

- (void) updatePlayerQueueWithMediaCollection: (MPMediaItemCollection*)collection {
	TrafficAppDelegate* delegate;
	delegate = (TrafficAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	MPMusicPlayerController* player = delegate.iPodPlayer;
	
	[player setQueueWithItemCollection:collection];
	
	[player play];
	
}

- (void) mediaPicker: (MPMediaPickerController *) mediaPicker
   didPickMediaItems: (MPMediaItemCollection *) collection {
	
    [self dismissModalViewControllerAnimated: YES];
    [self updatePlayerQueueWithMediaCollection: collection];
}

- (IBAction) iPodPlay:(id)sender {
	TrafficAppDelegate* delegate;
	delegate = (TrafficAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	MPMusicPlayerController* player = delegate.iPodPlayer;
	
	MPMusicPlaybackState state = player.playbackState;
	
	if (state == MPMusicPlaybackStatePaused ||
		state == MPMusicPlaybackStateStopped) {
		[player play];
	}
	
	if (state == MPMusicPlaybackStatePlaying) {
		[player pause];
	}
}

- (IBAction) iPodNext:(id)sender {
	TrafficAppDelegate* delegate;
	delegate = (TrafficAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	MPMusicPlayerController* player = delegate.iPodPlayer;
	
	[player skipToNextItem];
}

- (IBAction) iPodBack:(id)sender {
	TrafficAppDelegate* delegate;
	delegate = (TrafficAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	MPMusicPlayerController* player = delegate.iPodPlayer;
	
	[player skipToPreviousItem];
}




@end
