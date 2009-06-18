//
//  PSPlayerController.h
//  Baddleships
//
//  Created by Marc Ammann on 6/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSPlayFieldController.h"

@protocol BSPlayerControllerInteractionDelegate
// current player shot at player at tile
- (void)player:(id)aPlayer shotPlayer:(id)shotPlayer atTile:(CGPoint)tile;
// when the player did really pause the game
- (void)playerDidPauseGame:(id)aPlayer;
// when the player did resume again
- (void)playerDidResumeGame:(id)aPlayer;
// asks if a player can pause the game
- (BOOL)playerCanPauseGame:(id)aPlayer;
// tells that a player did quit
- (void)playerDidQuitGame:(id)aPlayer;
@end


@interface BSPlayerController : NSObject <BSPlayFieldInteractionDelegate> {
	// Where all the user interactions are sent to
	id<BSPlayerControllerInteractionDelegate> interactionDelegate;
	
	// Is the player active?
	BOOL isActive;
	
	// Array of received shots
	NSMutableArray *shotsReceived;
	
	// Array of shots made
	NSMutableArray *shotsMade;
	
	// Array of enemies
	NSMutableArray *opposingPlayers;
	
	// Players own field
	BSPlayFieldController *playerField;
}

@property (nonatomic, assign) id<BSPlayerControllerInteractionDelegate> interactionDelegate;
@property (nonatomic, readwrite) BOOL isActive;

- (id)init;

@end
