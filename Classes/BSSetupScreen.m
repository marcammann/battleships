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
		
		playFieldController = [[BSPlayFieldController alloc] initWithTilenumber:10];
		
		[self createShips];
    }
    return self;
}

- (void)createShips {
	NSMutableArray *sizeCount = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], // Size 0
								 [NSNumber numberWithInt:0], // Size 1
								 [NSNumber numberWithInt:4], // Size 2
								 [NSNumber numberWithInt:3], // Size 3
								 [NSNumber numberWithInt:2], // Size 4
								 [NSNumber numberWithInt:1], nil]; // Size 5
	
	NSMutableArray *theShips = [NSMutableArray array];
	int j = 0;
	for (NSNumber *count in sizeCount) {
		for (int i = 0; i < [count integerValue]; i++) {
			// Create the Ships
			BSShipController *aShip = [[BSShipController alloc] initWithType:BSShipType3];
			
			// Set the delegate to the playFieldController
			aShip.delegate = playFieldController;

			[theShips addObject:aShip];
		}
		j++;
	}
	
	ships = [[NSArray arrayWithArray:theShips] retain];
}


- (void)drawRect:(CGRect)rect {
	[canvas addSubview:playFieldController.view];
	
	for (BSShipController *aShip in ships) {
		[canvas addSubview:aShip.view];
		aShip.view.center = CGPointMake(120.0f, 120.0f);
	}
	
	[self addSubview:canvas];
}


- (void)dealloc {
    [super dealloc];
}


@end
