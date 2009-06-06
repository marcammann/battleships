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

@protocol BSShipDelegate
- (void)ship:(id)aShip movedToPoint:(CGPoint)aPoint;
- (void)ship:(id)aShip rotatedToOrientation:(BSShipOrientation)anOrientation;
- (CGPoint)ship:(id)aShip pointToMoveForPoint:(CGPoint)aPoint;
- (BOOL)ship:(id)aShip shouldMoveToPoint:(CGPoint)aPoint;
@end

@interface BSShipController : UIViewController {
	// The Ship view
	BSShipView *view;
	
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
	id delegate;
}

// Returns a point with the tile position in the current play field
- (CGPoint)positionInGrid;

@property (nonatomic, retain) BSShipView *view;

@property (readwrite, getter=isMovable) BOOL movable;
@property (readwrite, getter=isRotatable) BOOL rotatable;

@property (nonatomic, readwrite) BSShipOrientation orientation;
@property (nonatomic, readwrite) BSShipType type;

@property (nonatomic, retain) NSNumber *length;

@property (nonatomic, assign) id playFieldController;
@property (nonatomic, assign) id delegate;


@end
