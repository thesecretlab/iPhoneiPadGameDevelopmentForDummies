//
//  CarsAppDelegate.h
//  Cars
//
//  Created by Jonathon Manning on 25/10/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <MediaPlayer/MPMusicPlayerController.h>

@class TrafficViewController;
@class MainMenuViewController;
@class StatsViewController;
@class SettingsViewController;

@interface TrafficAppDelegate : NSObject <UIApplicationDelegate, AVAudioPlayerDelegate> {
    UIWindow *window;
	
	UINavigationController *navigationController;
	
    TrafficViewController *gameViewController;
	MainMenuViewController *mainMenu;
	StatsViewController *statsViewController;
	SettingsViewController *settingsViewController;
	
	UIViewController *currentViewController;
	
	NSString* scoresListPath;

	NSMutableArray* scoresList;
	
	BOOL shouldPlayMusic;
	BOOL shouldPlaySFX;
	
	BOOL audioSourceIsIPodLibrary;
	
	AVAudioPlayer* musicPlayer;
	
	MPMusicPlayerController* iPodPlayer;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet TrafficViewController *gameViewController;
@property (nonatomic, retain) IBOutlet MainMenuViewController *mainMenu;
@property (nonatomic, retain) IBOutlet StatsViewController *statsViewController;
@property (nonatomic, retain) IBOutlet SettingsViewController *settingsViewController;

@property (nonatomic, retain) NSMutableArray* scoresList;

@property (nonatomic, retain) MPMusicPlayerController* iPodPlayer;

-(void) newGame;
-(void) endGame;

-(void)addHighScore:(NSInteger)score;

@property (assign) BOOL shouldPlayMusic;
@property (assign) BOOL shouldPlaySFX;
@property (assign) BOOL audioSourceIsIPodLibrary;
@end

