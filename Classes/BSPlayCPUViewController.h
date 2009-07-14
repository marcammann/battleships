//
//  BSPlayCPUViewController.h
//  Baddleships
//
//  Created by Marc Ammann on 6/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSGameController.h"
#import "BSPlayFieldController.h"
#import "BSShootingFieldController.h"
#import "BSPlayerControllerHuman.h"
#import "BSSettings.h"
#import "BSShipController.h"
#import "BSCanvasView.h"

@interface BSPlayCPUViewController : UIViewController <BSPlayerControllerWindowDelegate> {
	// The current game controller
	BSGameController *game;
	
	// The players play field, in small
	BSPlayFieldController *ownPlayField;
	
	// The players shoting field
	BSShootingFieldController *shootingPlayField;
	
	// The canvas
	BSCanvasView *canvas;
	
	// The human player
	BSPlayerControllerHuman *player;
	
	// Settings
	BSSettings *settings;
}

- (id)initWithGame:(BSGameController *)aGame player:(BSPlayerControllerHuman *)player settings:(BSSettings *)settings;

@end
