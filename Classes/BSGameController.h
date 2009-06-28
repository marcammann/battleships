//
//  BSGameController.h
//  Baddleships
//
//  Created by Marc Ammann on 6/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSPlayerController.h"
#import "BSShot.h"

@protocol BSGameControllerPlayerDelegate
- (void)game:(id)aGame madeShot:(BSShot *)aShot;
- (void)game:(id)aGame hasWinner:(BSPlayerController *)aPlayer;
@end


@interface BSGameController : NSObject <BSPlayerControllerInteractionDelegate> {
	// Array of players
	NSMutableArray *players;
	
	// Array of shots - cached.
	NSMutableArray *shots;
	
	// The winner of the game
	BSPlayerController<BSGameControllerPlayerDelegate> *winner;
}

@property (readonly, getter=winner) BSPlayerController *winner; 
@property (nonatomic, readonly) NSMutableArray *players;
@property (nonatomic, readonly) NSMutableArray *shots;


// Check if the game has a winner
- (BOOL)hasWinner;
- (void)addPlayer:(BSPlayerController *)player;

@end
