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
#import "BSPlayerControllerHuman.h"
#import "BSPlayerControllerCPU.h"
#import "BSSettings.h"
#import "BSGameController.h"
#import "BSPlayCPUViewController.h"

@interface BSBaseRectangle : NSObject
{
	CGRect rect;
	NSInteger shipCount;
}

@property (nonatomic, readwrite) CGRect rect;
@property (nonatomic, readwrite) NSInteger shipCount;

+ (id)rectangleWithRect:(CGRect)aRect shipCount:(NSInteger)aShipCount;

@end


@interface BSSetupCPUViewController : UIViewController  <BSPlayFieldInteractionDelegate> {
	// The game
	BSGameController *game;
	
	// The player
	BSPlayerControllerHuman *player;
	
	// The canvas where we draw ships and fields on
	BSCanvasView *canvas;
	
	// The playfield
	BSPlayFieldController *playField;
	
	// The settings
	BSSettings *settings;
	
	// The rectangles that the ships are initially in
	NSMutableDictionary *baseRectangles;
	
	// The amount labels for the rectangles
	NSMutableDictionary *baseLabels;
	
	// "done" button & "help" button
	UIButton *doneButton;
	UIButton *helpButton;
}

// Initializer
- (id)initWithSettings:(BSSettings *)theSettings;

// Sets the frames for the ships etc.
- (void)layoutViews;

// Button Delegates
- (void)doneButtonPressed:(id)sender;
- (void)helpButtonPressed:(id)sender;

@end
