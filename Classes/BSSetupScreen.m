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
		
		playFieldController = [[BSPlayFieldController alloc] initWithSize:[NSNumber numberWithInt:10] frame:CGRectMake(342.0f, 0.0f, 128.0f, 128.0f)];
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
	//[playFieldController.view.layer setTransform:CATransform3DMakeScale(0.5f, 0.5f, 1.0f)];
	
	BSShipController *ship = [[BSShipController alloc] initWithType:BSShipType3 tileSize:12.0f];
	ship.delegate = playFieldController;
	//ship.view.center = CGPointMake(200.0f, 200.0f);
	ship.position = CGPointMake(3, 4);
	[ship setCoordinateToPosition];
	
	for (BSShipController *aShip in ships) {
		[canvas addSubview:aShip.view];
		aShip.position = CGPointMake(2, 2);
		//aShip.view.center = CGPointMake(120.0f, 120.0f);
		[aShip setCoordinateToPosition];
	}
	
	[canvas addSubview:ship.view];
	
	
	
	[self addSubview:canvas];
}


- (void)dealloc {
    [super dealloc];
}


@end
