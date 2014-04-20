//
//  SettingsViewController.h
//  Traffic
//
//  Created by Jonathon Manning on 1/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMediaPickerController.h>


@interface SettingsViewController : UIViewController <MPMediaPickerControllerDelegate> {
	UILabel* nowPlaying;
	UISwitch* musicSwitch;
	UISwitch* sfxSwitch;
	
	UIView* iPodControls;
	
	UIButton* playPauseButton;
	
	UISegmentedControl* audioSource;
}

@property (nonatomic, retain) IBOutlet UILabel* nowPlaying;
@property (nonatomic, retain) IBOutlet UISwitch* musicSwitch;
@property (nonatomic, retain) IBOutlet UISwitch* sfxSwitch;
@property (nonatomic, retain) IBOutlet UIView* iPodControls;
@property (nonatomic, retain) IBOutlet UISegmentedControl* audioSource;
@property (nonatomic, retain) IBOutlet UIButton* playPauseButton;



- (IBAction) changedMusicSetting:(id)sender;
- (IBAction) changedSFXSetting:(id)sender;

- (IBAction) iPodPlay:(id)sender;
- (IBAction) iPodNext:(id)sender;
- (IBAction) iPodBack:(id)sender;
- (IBAction) openMusicPicker:(id)sender;

- (IBAction) changedAudioSource:(id)sender;

- (IBAction) goBack:(id)sender;

@end
