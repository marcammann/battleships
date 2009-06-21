//
//  BSPlayFieldController.h
//  Baddleships
//
//  Created by Marc Ammann on 4/1/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSPlayFieldView.h"
#import "BSShipController.h"

#import "Constants.h"

@protocol BSPlayFieldDisplayDelegate
- (void)playField:(id)field allShipsInField:(BOOL)inField;
@end

@protocol BSPlayFieldInteractionDelegate
@optional
- (void)playField:(id)aField tappedAt:(CGPoint)aPoint;
- (void)playField:(id)aField ship:(BSShipController *)aShip movedToPoint:(CGPoint)coordinate;
@end


@interface BSPlayFieldController : UIViewController <BSShipDelegate, BSPlayFieldViewDelegate> {
	// The delegate to send actions to
	id<BSPlayFieldDisplayDelegate> delegate;
	
	// The delegate that receives ships moving around etc.
	id<BSPlayFieldInteractionDelegate> interactionDelegate;
	
	// Size of the Field in number of tiles
	NSNumber *size;
	
	// Mutable Array of the ships on the field
	NSMutableArray *ships;
	
	// The Play Field View (duh!)
	BSPlayFieldView *view;
	
	// If the Field is Touch Enabled (to mark a field)
	BOOL touchEnabled;
}

// Initializer with size
- (id)initWithSize:(NSNumber *)size frame:(CGRect)aFrame;

// Adds a ship to the field - and thus sets the delegate etc.
- (void)addShip:(BSShipController *)aShip;

// Returns the closest point in the grid for a point
- (CGPoint)gridpointForCoordinate:(CGPoint)aPoint;

// Returns the coordinates in the parent view for a given point
- (CGPoint)coordinateForGridpoint:(CGPoint)aPoint;

// Returns the tile a certain point is in
- (CGPoint)tileForCoordinate:(CGPoint)aPoint;

// Returns all Tiles that have multiple ships on them - and are thus blocking.
- (NSArray *)multiAssignments;

// Returns the left upper point where the grid starts
- (CGPoint)gridOffset;

// Sets a tile in the field as marked
- (void)setTileMarked:(CGPoint)tile;

// Checks if a gridpoint is really in the grid
- (BOOL)gridpointInGrid:(CGPoint)gridpoint;

// Checks if a coordinate is on the grid
- (BOOL)coordinateInGrid:(CGPoint)coordinate;

// Checks if a ship is fully on the grid
- (BOOL)isShipInGrid:(BSShipController *)theShip;

// Checks if all ships are in the grid
- (BOOL)shipsInGrid;

// Sets the tile size in the view and all ships
- (void)setTileSize:(CGFloat)aTileSize;

@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) id interactionDelegate;
@property (nonatomic, retain) NSNumber *size;
@property (nonatomic, readonly) NSMutableArray *ships;
@property (nonatomic, retain) BSPlayFieldView *view;
@property (readwrite) BOOL touchEnabled;

@end
