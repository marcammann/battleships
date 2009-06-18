//
//  BSPlayCPUViewController.h
//  Battleships
//
//  Created by Marc Ammann on 3/28/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSSetupScreen.h"
#import "BSCanvasView.h"
#import "BSPlayFieldController.h"
#import "BSShipController.h"
#import "BSPlayerController.h"
#import "BSSettings.h"

@interface BSSetupCPUViewController : UIViewController {
	//BSSetupScreen *screen;
	
	// The player
	BSPlayerController *player;
	
	// The canvas where we draw ships and fields on
	BSCanvasView *canvas;
	
	// The playfield
	BSPlayFieldController *playField;
	
	// The settings
	BSSettings *settings;
}

// Create ships, according to the settings
- (void)createShips;
- (void)create:(NSInteger)amount ofShipsWithType:(BSShipType)type atPosition:(CGPoint)leftUpper;

@end
