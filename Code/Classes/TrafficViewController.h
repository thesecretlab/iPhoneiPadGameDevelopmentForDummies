//
//  CarsViewController.h
//  Cars
//
//  Created by Jonathon Manning on 25/10/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TrafficController;
@class	PathDrawer;

@interface TrafficViewController : UIViewController {
	TrafficController* gameController;
	
	UIView* pauseOverlay;
	UIButton* overlayButton;
	UIButton* endButton;
	
	UILabel* timeRemainingLabel;
	
	UIView* gameOverOverlay;
	
}

@property (nonatomic, retain) IBOutlet TrafficController* gameController;
@property (nonatomic, retain) IBOutlet UIButton* overlayButton;
@property (nonatomic, retain) IBOutlet UIButton* endButton;
@property (nonatomic, retain) IBOutlet UIView* gameOverOverlay;
@property (nonatomic, retain) IBOutlet UIView* pauseOverlay;
@property (nonatomic, retain) IBOutlet UILabel* timeRemainingLabel;

-(IBAction) pauseGame:(id)sender;
-(void)displayGameOver;
-(IBAction) endGame:(id)sender;

- (void)setTimeRemaining:(CGFloat)score;

@end

