//
//  BSShipController.h
//  Baddleships
//
//  Created by Marc Ammann on 6/6/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BSShipView.h"

typedef enum {
	BSShipOrientationHorizontal,
	BSShipOrientationVertical,
} BSShipOrientation;

typedef enum {
	BSShipType2,
	BSShipType3,
	BSShipType4,
	BSShipType5,
} BSShipType;

typedef enum {
	BSShipSizeSmall,
	BSShipSizeLarge,
} BSShipSize;

@protocol BSShipDelegate
- (void)ship:(id)aShip movedToPoint:(CGPoint)aPoint;
- (void)ship:(id)aShip rotatedToOrientation:(BSShipOrientation)anOrientation;
- (CGPoint)ship:(id)aShip pointToMoveForPoint:(CGPoint)aPoint;
- (CGPoint)ship:(id)aShip closestBoundaryPointForPoint:(CGPoint)aPoint;
- (BOOL)ship:(id)aShip shouldMoveToPoint:(CGPoint)aPoint;
- (BOOL)isShipInGrid:(id)aShip;
@end

@interface BSShipController : UIViewController <BSShipViewDelegate> {
	// The Ship view
	BSShipView *shipView;
	
	// Is the ship still movable
	BOOL movable;
	
	// Is the ship rotatable
	BOOL rotatable;
	
	// The Ships orientation
	BSShipOrientation orientation;
	
	// The Type of the ship (how many fields), may later be extended to some special types
	BSShipType type;

	// The play field the ship is in, nil if not in a field yet
	id playFieldController;
	
	// Number of tiles the ship is long, other information can be found in the view
	NSNumber *length;
	
	// The Delegate, preferably the play field controller, to tell the ship, what it can do
	id<BSShipDelegate> delegate;
	
	// The hits this ship has taken
	NSMutableArray *hits;
	
	// How big is one tile
	CGFloat tileSize;
	
	// The position in the grid
	CGPoint position;
	
	// Coordinates relative to the play field
	CGPoint relativeCoordinates;
}

// Initializer with the type
- (id)initWithType:(BSShipType)type;

// Returns a point with the tile position in the current play field
- (CGPoint)positionInGrid;

// Checks if a point would mean a hit on this ship
- (BOOL)checkHitForPoint:(CGPoint)point;

// Sets a point on the ship as hit.
- (void)setHit:(CGPoint)tile;

// Sets or Moves the ship to some other coordinates
- (void)setCoordinate:(CGPoint)aPoint animated:(BOOL)animated;

// Used to move/resize a ship
- (void)setSize:(BSShipSize)aSize position:(CGPoint)aPosition animated:(BOOL)animated;

// Returns the coordinates of the center of a tile of a ship
- (CGPoint)centerCoordinateForShipTile:(NSInteger)aTile;

// Rotates the Ship around a specified point
- (void)setOrientation:(BSShipOrientation)anOrientation aroundAnchor:(CGPoint)anAnchor;

@property (nonatomic, retain) BSShipView *shipView;

@property (readwrite, getter=isMovable) BOOL movable;
@property (readwrite, getter=isRotatable) BOOL rotatable;

@property (nonatomic, readwrite) BSShipOrientation orientation;
@property (nonatomic, readwrite) BSShipType type;
@property (nonatomic, readwrite) CGFloat tileSize;

@property (nonatomic, readonly) NSNumber *length;

@property (nonatomic, assign) id playFieldController;
@property (nonatomic, assign) id delegate;

@property (nonatomic, readwrite) CGPoint position;
@property (nonatomic, readwrite) CGPoint relativeCoordinates;


@end
