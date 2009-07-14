//
//  BSSetupScreen.m
//  Battleships
//
//  Created by Marc Ammann on 3/31/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import "BSSetupScreen.h"
#import "Constants.h"

#import "BSShipController.h"
#import "BSPlayScreen.h"

@implementation BSSetupScreen

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		canvas = [[BSCanvasView alloc] initWithFrame:frame];
		
		//playFieldController = [[BSPlayFieldController alloc] initWithSize:[NSNumber numberWithInt:10] frame:CGRectMake(342.0f, 0.0f, 128.0f, 128.0f)];
		ownFieldController = [[BSPlayFieldController alloc] initWithSize:[NSNumber numberWithInt:10] frame:CGRectMake(0.0f, 0.0f, 320.0f, 320.0f)];
		ownFieldController.delegate = self;
		
		helpButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
		[helpButton setTitle:@"?" forState:UIControlStateNormal];
		
		continueButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
		[continueButton setTitle:@"OK" forState:UIControlStateNormal];
		[continueButton setEnabled:NO];
		[continueButton addTarget:self action:@selector(openPlayScreen) forControlEvents:UIControlEventTouchUpInside];
		[self createShips];
		[ownFieldController createRandomPlayField:ships];
    }
    return self;
}


- (void)openPlayScreen {
	BSPlayScreen *playScreen = [[BSPlayScreen alloc] initWithFrame:self.frame];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}


- (void)createShips {
	NSMutableArray *sizeCount = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0],
								 [NSNumber numberWithInt:0],
								 [NSNumber numberWithInt:0],
								 [NSNumber numberWithInt:0],
								 [NSNumber numberWithInt:1],
								 [NSNumber numberWithInt:1],
								 [NSNumber numberWithInt:1],
								 [NSNumber numberWithInt:2],
								 [NSNumber numberWithInt:2],
								 [NSNumber numberWithInt:3], nil];
	
	NSMutableArray *theShips = [NSMutableArray array];
	for (NSNumber *count in sizeCount) {
		// Create the Ships
		BSShipController *aShip = [[BSShipController alloc] initWithType:[count intValue] tileSize:kTileSize];
		
		[ownFieldController addShip:aShip];
		// Set the delegate to the playFieldController
		[theShips addObject:aShip];
	}
	
	ships = [[NSArray arrayWithArray:theShips] retain];
}

- (void)drawRect:(CGRect)rect {
	//[canvas addSubview:playFieldController.view];
	[canvas addSubview:ownFieldController.fieldView];
	UInt32 i = 0;
	for (BSShipController *aShip in ships) {
		switch (i) {
			case 0:
			case 1:
			case 2:
			case 3:
				[aShip setOrientation:BSShipOrientationVertical];
				[aShip setCoordinate:CGPointMake(325.0f + (i * 34.0f), 3 * 34.0f + 5.0f) animated:NO];
				break;
			case 4:
			case 5:
				[aShip setOrientation:BSShipOrientationHorizontal];
				[aShip setCoordinate:CGPointMake(325.0f + 34.0f, 3 * 34.0f + 64.0f + ((i - 4) * 34.0f) + 5.0f) animated:NO];
				break;
			case 6:
				[aShip setOrientation:BSShipOrientationVertical];
				[aShip setCoordinate:CGPointMake(325.0f, 3 * 34.0f + 64.0f + 5.0f) animated:NO];
				break;
			case 7:
			case 8:
				[aShip setOrientation:BSShipOrientationHorizontal];
				[aShip setCoordinate:CGPointMake(325.0f, (i - 6) * 34.0f + 5.0f) animated:NO];
				break;
			case 9:
				[aShip setOrientation:BSShipOrientationHorizontal];
				[aShip setCoordinate:CGPointMake(325.0f, 5.0f) animated:NO];
				break;
			default:
				break;
		}
		
		i++;
		
		[canvas addSubview:aShip.shipView];
//		[aShip setOrientation:BSShipOrientationVertical];
//		[aShip setCoordinate:CGPointMake(340.0f, 20.0f + i*32.0f) animated:NO];
	}
	
	
	
	[self addSubview:canvas];
	
	continueButton.frame = CGRectMake(370.0f, 275.0f, 40.0f, 40.0f);
	[self addSubview:continueButton];
	
	helpButton.frame = CGRectMake(325.0f, 275.0f, 40.0f, 40.0f);
	[self addSubview:helpButton];
}

/*
// For test random ships
- (void)drawRect:(CGRect)rect {
	//[canvas addSubview:playFieldController.view];
	[canvas addSubview:ownFieldController.view];
	
	for (BSShipController *aShip in ownFieldController.randomShips) {
		[canvas addSubview:aShip.view];
	}
	[self addSubview:canvas];
}	
*/

# pragma mark BSPlayFieldDelegate Methods

- (void)playField:(id)field allShipsInField:(BOOL)inField {
	[continueButton setEnabled:inField];
}

- (void)dealloc {
    [super dealloc];
}


@end
