//
//  PathDrawer.h
//  Traffic
//
//  Created by Jonathon Manning on 1/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PathDrawer : UIView {
	NSMutableArray* paths;
}

@property (nonatomic, readonly) NSMutableArray* paths;

@end
