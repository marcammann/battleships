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

- (id)init {
	if (self = [super init]) {
		// The current player
		player = [[BSPlayerController alloc] init];
		
		// Create the canvas
		canvas = [[BSCanvasView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 480.0f, 320.0f)];
		
		// Create the play field
		playField = [[BSPlayFieldController alloc] initWithSize:[NSNumber numberWithInt:10]];
		playField.interactionDelegate = self;
		playField.delegate = self;
		
		helpButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
		doneButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
		// Disable the done button as long as not all ships are placed
		//doneButton.enabled = NO;
		
		// Create the Ships
		[self createShips];
	}
	
	return self;
}

- (void)createShips {
	CGFloat leftOffset = 325.0f;	
	baseRectangles = [[NSMutableDictionary dictionaryWithCapacity:4] retain];
	baseLabels = [[NSMutableDictionary dictionaryWithCapacity:4] retain];
	
	// Create the Ships and their base rectangles
	[self create:1 ofShipsWithType:BSShipType5 atPosition:CGPointMake(leftOffset, 10.0f)];
	[self create:3 ofShipsWithType:BSShipType4 atPosition:CGPointMake(leftOffset, 50.0f)];
	[self create:2 ofShipsWithType:BSShipType3 atPosition:CGPointMake(leftOffset, 90.0f)];
	[self create:4 ofShipsWithType:BSShipType2 atPosition:CGPointMake(leftOffset, 130.0f)];
}

- (void)create:(NSInteger)amount ofShipsWithType:(BSShipType)type atPosition:(CGPoint)leftUpper {
	for (int i = 0; i < amount; i++) {
		BSShipController *ship = [[BSShipController alloc] initWithType:type];
		ship.tileSize = 30.0f;
		[playField addShip:ship];
		[canvas addSubview:ship.view];
		[ship setOrientation:BSShipOrientationHorizontal];
		[ship setCoordinate:leftUpper animated:NO];
	}
	
	[baseRectangles setObject:[BSBaseRectangle rectangleWithRect:CGRectMake(leftUpper.x - 5.0f, leftUpper.y - 5.0f, 160.0f, 40.0f) shipCount:amount] forKey:[NSNumber numberWithInt:type]];
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftUpper.x - 5.0f, leftUpper.y - 5.0f, 40.0f, 40.0f)];
	label.text = [NSString stringWithFormat:@"%i", amount];
	[baseLabels setObject:label forKey:[NSNumber numberWithInt:type]];
	
	//[canvas addSubview:label];
}

- (void)loadView {
	[super loadView];
	
	// Setup the canvas and create the ships
	[canvas insertSubview:playField.fieldView atIndex:0];
	[self.view addSubview:canvas];
	
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

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	//[playField setTileSize:12.0f];
	//[playField.view setNeedsDisplay];
}

- (void)animatePlayFieldToSmall {
	[playField setSize:BSViewSizeSmall position:CGPointMake(330.0f, 0.0f) animated:YES];
}
	


- (void)doneButtonPressed:(id)sender {
	[playField setSize:BSViewSizeLarge position:CGPointMake(0.0f, 0.0f) animated:YES];
}

- (void)helpButtonPressed:(id)sender {
	[self animatePlayFieldToSmall];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)dealloc {
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
	//doneButton.enabled = inField;
}

@end
