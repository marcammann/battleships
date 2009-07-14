//
//  BSPlayCPUViewController.m
//  Battleships
//
//  Created by Marc Ammann on 3/28/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import "BSSetupCPUViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation BSBaseRectangle

@synthesize rect, shipCount;

+ (id)rectangleWithRect:(CGRect)aRect shipCount:(NSInteger)aShipCount {
	BSBaseRectangle *baseRect = [[[BSBaseRectangle alloc] init] autorelease];
	baseRect.rect = aRect;
	baseRect.shipCount = aShipCount;
	
	return baseRect;
}
@end


@implementation BSSetupCPUViewController

- (id)initWithSettings:(BSSettings *)theSettings {
	if (self = [super init]) {
		settings = [theSettings retain];
		
		game = [[BSGameController alloc] init];
		
		// The current player
		player = [[BSPlayerControllerHuman alloc] initWithSettings:settings];
		player.playField.interactionDelegate = self;
		player.playField.delegate = self;
		[game addPlayer:player];
		
		playField = player.playField;
		
		// Create a CPU player
		//BSPlayerControllerCPU *cpuPlayer = [[BSPlayerControllerCPU alloc] initWithSettings:settings];
		//[game addPlayer:cpuPlayer];
		
		// Create the canvas
		canvas = [[BSCanvasView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 480.0f, 320.0f)];
		canvas.backgroundColor = [UIColor purpleColor];
		
		// Create the buttons
		helpButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
		doneButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
		
		// Disable the done button as long as not all ships are placed
		doneButton.enabled = NO;
	}
	
	return self;
}


- (void)loadView {
	[super loadView];
	
	// Setup the canvas and create the ships
	[self.view addSubview:canvas];
	
	[self layoutViews];
	
	// Setup the 2 Buttons
	helpButton.frame = CGRectMake(0.0f, 0.0f, 60.0f, 40.0f);
	helpButton.center = CGPointMake(320.0f + 45.0f, 290.0f);
	[helpButton setTitle:NSLocalizedString(@"Help", nil) forState:UIControlStateNormal];
	[helpButton addTarget:self action:@selector(helpButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:helpButton];
	
	doneButton.frame = helpButton.frame;
	doneButton.center = CGPointMake(320.0f + 45.0f + 70.0f, 290.0f);
	[doneButton setTitle:NSLocalizedString(@"Done", nil) forState:UIControlStateNormal];
	[doneButton addTarget:self action:@selector(doneButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:doneButton];
}


- (void)layoutViews {
	[canvas insertSubview:playField.fieldView atIndex:0];
	playField.fieldView.frame = CGRectMake(0.0f, 0.0f, 320.0f, 320.0f);
	
	CGFloat leftOffset = 325.0f;
	CGFloat topOffset = 20.0f;
	CGFloat diff = 40.0f;
	for (BSShipController *ship in playField.ships) {		
		[canvas addSubview:ship.view];
		[ship setOrientation:BSShipOrientationHorizontal];
		[ship setCoordinate:CGPointMake(leftOffset, topOffset + ship.type * diff) animated:NO];
	}
}


- (void)doneButtonPressed:(id)sender {
	[playField generateOccupiedTileCache];
	BSPlayCPUViewController *cpuPlayField = [[BSPlayCPUViewController alloc] initWithGame:game player:player settings:settings];
	[self.navigationController pushViewController:cpuPlayField animated:NO];
}


- (void)showShootingGrid {
	
	//[self.view addSubview:cpuPlayView.view];
	
}


- (void)helpButtonPressed:(id)sender {
	playField.touchEnabled = YES;
	[playField setSize:BSViewSizeLarge position:CGPointMake(0.0f, 0.0f) animated:YES];
}


- (void)dealloc {
	[settings release];
	[helpButton release];
	[doneButton release];
	[canvas release];
	[playField release];
    [super dealloc];
}


# pragma mark BSPlayFieldInteractionDelegate Methods

- (void)playField:(id)aField ship:(BSShipController *)aShip movedToPoint:(CGPoint)coordinate {
	
}


# pragma mark BSPlayFieldDisplayDelegate Methods

- (void)playField:(id)field allShipsInField:(BOOL)inField {
	doneButton.enabled = inField;
}

@end
