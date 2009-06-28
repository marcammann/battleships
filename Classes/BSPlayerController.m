//
//  PSPlayerController.m
//  Baddleships
//
//  Created by Marc Ammann on 6/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BSPlayerController.h"


@implementation BSPlayerController

@synthesize interactionDelegate;
@synthesize windowDelegate;
@synthesize isActive;
@synthesize playField;
@synthesize shootingField;
@synthesize settings;

- (id)initWithSettings:(BSSettings *)theSettings {
	if (self = [super init]) {
		settings = theSettings;
		[self createPlayField];
		[self createShips];
	}
	
	return self;
}

- (void)createPlayField {
	playField = [[BSPlayFieldController alloc] initWithSize:[NSNumber numberWithInt:10]];
}

- (void)createShips {
	// Create the Ships and their base rectangles
	[self create:1 ofShipsWithType:BSShipType5 atPosition:CGPointZero];
	//[self create:3 ofShipsWithType:BSShipType4 atPosition:CGPointZero];
	//[self create:2 ofShipsWithType:BSShipType3 atPosition:CGPointZero];
	//[self create:3 ofShipsWithType:BSShipType2 atPosition:CGPointZero];
}

- (void)create:(NSInteger)amount ofShipsWithType:(BSShipType)type atPosition:(CGPoint)leftUpper {
	for (int i = 0; i < amount; i++) {
		BSShipController *ship = [[BSShipController alloc] initWithType:type];
		ship.tileSize = 30.0f;
		[playField addShip:ship];
		[ship setCoordinate:leftUpper animated:NO];
	}
}


- (void)game:(id)aGame madeShot:(BSShot *)shot {
	if (shot.sender == self) {
		if (shot.hit) {
			[playField setTileHit:shot.tile];
		} else {
			[playField setTileMarked:shot.tile];
		}
	}
	
	if (shot.receiver == self) {
		if (shot.hit) {
			[shootingField setTileHit:shot.tile];
		} else {
			[shootingField setTileMarked:shot.tile];
		}
	}
}

- (void)game:(id)aGame hasWinner:(BSPlayerController *)aPlayer {
	[windowDelegate player:self endedGame:aGame withWinner:aPlayer];
}

@end
