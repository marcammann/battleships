//
//  BSPlayCPUViewController.m
//  Battleships
//
//  Created by Marc Ammann on 3/28/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import "BSSetupCPUViewController.h"


@implementation BSSetupCPUViewController

- (id)init {
	if (self = [super init]) {
		// Create the canvas
		canvas = [[BSCanvasView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
		
		// Create the play field
		playField = [[BSPlayFieldController alloc] initWithSize:[NSNumber numberWithInt:10]];
	}
	
	return self;
}

- (void)createShips {
	// Read from settings how many ships to create from each
	[self create:2 ofShipsWithType:BSShipType3 atPosition:CGPointMake(330.0f, 20.0f)];
}

- (void)create:(NSInteger)amount ofShipsWithType:(BSShipType)type atPosition:(CGPoint)leftUpper {
	for (int i = 0; i < amount; i++) {
		BSShipController *ship = [[BSShipController alloc] initWithType:type];
		ship.tileSize = 30.0f;
		[playField addShip:ship];
		[canvas addSubview:ship.view];
	}
}

- (void)loadView {
	[super loadView];
	
	// Setup the canvas and create the ships
	[canvas addSubview:playField.view];
	[self createShips];
	[self.view addSubview:canvas];
	
	// Setup the 2 Buttons
	UIButton *helpButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	helpButton.frame = CGRectMake(0.0f, 0.0f, 60.0f, 40.0f);
	helpButton.center = CGPointMake(320.0f + 45.0f, 290.0f);
	[helpButton setTitle:NSLocalizedString(@"Help", nil) forState:UIControlStateNormal];
	[self.view addSubview:helpButton];
	
	UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	doneButton.frame = helpButton.frame;
	doneButton.center = CGPointMake(320.0f + 45.0f + 70.0f, 290.0f);
	[doneButton setTitle:NSLocalizedString(@"Done", nil) forState:UIControlStateNormal];
	[self.view addSubview:doneButton];
	
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


- (void)dealloc {
	[canvas release];
	[playField release];
    [super dealloc];
}


@end
