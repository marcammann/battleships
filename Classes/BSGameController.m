//
//  BSGameController.m
//  Baddleships
//
//  Created by Marc Ammann on 6/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BSGameController.h"
#import "BSPlayerController.h"

@implementation BSGameController

@synthesize players, shots;

- (id)init {
	if (self = [super init]) {
		players = [[NSMutableArray array] retain];
		shots = [[NSMutableArray array] retain];
	}
	
	return self;
}

- (void)addPlayer:(BSPlayerController *)player {
	[players addObject:player];
}

- (void)player:(id)aPlayer shotPlayer:(id)shotPlayer atTile:(CGPoint)tile {
	BSShot *shot = [[BSShot alloc] init];
	shot.sender = aPlayer;
	shot.receiver = shotPlayer;
	shot.tile = tile;
	shot.hit = [[(BSPlayerController *)shotPlayer playField] isTileAssigned:tile];
	
	NSLog(@"shot: =======");
	CGLog(shot.tile);
	NSLog(@"%i", shot.hit);
	
	[shots addObject:shot];
	
	for (BSPlayerController *player in players) {
		[player shotMade:shot];
		
		if ([self  hasWinner]) {
			[player game:self wonByPlayer:player];
		}
	}
	
	
}

- (BOOL)hasWinner {
	int hits = 0;
	for (BSShot *shot in shots) {
		if (shot.hit) {
			hits++;
		}
	}
	
	if (hits == 5) {
		return YES;
	}
}

- (void)playerDidPauseGame:(id)aPlayer {
	
}

- (void)playerDidResumeGame:(id)aPlayer {
	
}

- (BOOL)playerCanPauseGame:(id)aPlayer {
	
}

- (void)playerDidQuitGame:(id)aPlayer {
	
}

@end

