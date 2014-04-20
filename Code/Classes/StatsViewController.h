//
//  StatsViewController.h
//  Traffic
//
//  Created by Jonathon Manning on 1/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StatsViewController : UIViewController {

	UILabel* score1;
	UILabel* score2;
	UILabel* score3;
	UILabel* score4;
}

@property (nonatomic, retain) IBOutlet UILabel* score1;
@property (nonatomic, retain) IBOutlet UILabel* score2;
@property (nonatomic, retain) IBOutlet UILabel* score3;
@property (nonatomic, retain) IBOutlet UILabel* score4;


- (IBAction) goBack:(id)sender;

@end
