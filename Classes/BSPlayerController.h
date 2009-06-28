//
//  PSPlayerController.h
//  Baddleships
//
//  Created by Marc Ammann on 6/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSShootingFieldController.h"
#import "BSPlayFieldController.h"
#import "BSSettings.h"
#import "BSShot.h"


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

@protocol BSPlayerControllerWindowDelegate
// Player did win
- (void)player:(id)aPlayer endedGame:(id)aGame withWinner:(id)aWinner;
@end


@interface BSPlayerController : NSObject <BSPlayFieldInteractionDelegate> {
	// Where all the user interactions are sent to
	id<BSPlayerControllerInteractionDelegate> interactionDelegate;
	
	// Where the visual response is sent
	id<BSPlayerControllerWindowDelegate> windowDelegate;
	
	// Is the player active?
	BOOL isActive;
	
	// Array of received shots
	NSMutableArray *shotsReceived;
	
	// Array of shots made
	NSMutableArray *shotsMade;
	
	// Array of enemies
	NSMutableArray *opposingPlayers;
	
	// Players own field
	BSPlayFieldController *playField;
	
	// Players shooting field
	BSShootingFieldController *shootingField;
	
	// Settings
	BSSettings *settings;
}

@property (nonatomic, assign) id<BSPlayerControllerInteractionDelegate> interactionDelegate;
@property (nonatomic, assign) id<BSPlayerControllerWindowDelegate> windowDelegate;
@property (nonatomic, readwrite) BOOL isActive;
@property (nonatomic, retain) BSSettings *settings;
@property (nonatomic, retain) BSPlayFieldController *playField;
@property (nonatomic, retain) BSShootingFieldController *shootingField;



- (id)initWithSettings:(BSSettings *)settings;
- (void)createShips;
- (void)createPlayField;
- (void)create:(NSInteger)amount ofShipsWithType:(BSShipType)type atPosition:(CGPoint)leftUpper;

- (void)game:(id)game hasWinner:(id)player;
- (void)game:(id)game madeShot:(id)player;

@end
