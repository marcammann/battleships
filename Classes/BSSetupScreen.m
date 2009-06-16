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

@implementation BSSetupScreen


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		canvas = [[BSCanvasView alloc] initWithFrame:frame];
		
		//playFieldController = [[BSPlayFieldController alloc] initWithSize:[NSNumber numberWithInt:10] frame:CGRectMake(342.0f, 0.0f, 128.0f, 128.0f)];
		ownFieldController = [[BSPlayFieldController alloc] initWithSize:[NSNumber numberWithInt:10] frame:CGRectMake(0.0f, 0.0f, 320.0f, 320.0f)];
		
		[self createShips];
    }
    return self;
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
		
		// Set the delegate to the playFieldController
		aShip.delegate = ownFieldController;
		[theShips addObject:aShip];
	}
	
	ships = [[NSArray arrayWithArray:theShips] retain];
}


- (void)drawRect:(CGRect)rect {
	[canvas addSubview:playFieldController.view];
	[canvas addSubview:ownFieldController.view];
	
	
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
		
		[canvas addSubview:aShip.view];
//		[aShip setOrientation:BSShipOrientationVertical];
//		[aShip setCoordinate:CGPointMake(340.0f, 20.0f + i*32.0f) animated:NO];
	}
	
	
	
	[self addSubview:canvas];
}


- (void)dealloc {
    [super dealloc];
}


@end
