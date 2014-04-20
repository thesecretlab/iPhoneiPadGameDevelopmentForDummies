//
//  MainMenuViewController.h
//  Traffic
//
//  Created by Jonathon Manning on 25/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MainMenuViewController : UIViewController {
	UIButton* newGameButton;
	UIButton* statsButton;
	UIButton* settingsButton;
	
	CAKeyframeAnimation* popAnimation;
}

@property (nonatomic, retain) IBOutlet UIButton* newGameButton;
@property (nonatomic, retain) IBOutlet UIButton* statsButton;
@property (nonatomic, retain) IBOutlet UIButton* settingsButton;

-(IBAction) newGame:(id)sender;
-(IBAction) showStats:(id)sender;
-(IBAction) showSettings:(id)sender;
	
@end
