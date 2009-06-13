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

@interface BSPlayFieldController : UIViewController <BSShipDelegate> {
	// Size of the Field in number of tiles
	NSNumber *size;
	
	// Mutable Array of the ships on the field
	NSMutableArray *ships;
	
	// The Play Field View (duh!)
	BSPlayFieldView *view;
}

// Initializer with size
- (id)initWithSize:(NSNumber *)size;

// Adds a ship to the field - and thus sets the delegate etc.
- (void)addShip:(BSShipController *)aShip;

// Returns the closest point in the grid for a point
- (CGPoint)gridpointForCoordinate:(CGPoint)aPoint;

// Returns the coordinates in the parent view for a given point
- (CGPoint)coordinateForGridpoint:(CGPoint)aPoint;

// Returns the tile a certain point is in
- (CGPoint)tileForPoint:(CGPoint)aPoint;

// Returns all Tiles that have multiple ships on them - and are thus blocking.
- (NSArray *)multiAssignments;

// Returns the left upper point where the grid starts
- (CGPoint)gridOffset;


@property (nonatomic, retain) NSNumber *size;
@property (nonatomic, readonly) NSMutableArray *ships;
@property (nonatomic, retain) BSPlayFieldView *view;

@end
