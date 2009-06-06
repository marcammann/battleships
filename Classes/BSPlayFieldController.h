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

// Adds a ship to the field - and thus sets the delegate etc.
- (void)addShip:(BSShipController *)aShip;

// Returns the closest point in the grid for a point
- (CGPoint)closestGridpointForPoint:(CGPoint)aPoint;

// Returns all Tiles that have multiple ships on them - and are thus blocking.
- (NSArray)multiPlacements;

@property (nonatomic, retain) NSNumber *size;
@property (nonatomic, readonly) NSMutableArray *ships;
@property (nonatomic, retain) BSPlayFieldView *view;

@end
