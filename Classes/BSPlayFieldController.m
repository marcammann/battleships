//
//  BSPlayFieldController.m
//  Baddleships
//
//  Created by Marc Ammann on 4/1/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import "BSPlayFieldController.h"
#import "BSShipView.h"
#import <QuartzCore/QuartzCore.h>


@implementation BSPlayFieldController

@synthesize fieldView;
@synthesize delegate;
@synthesize interactionDelegate;
@synthesize ships;

- (id)initWithSize:(NSNumber *)theSize {
	if (self = [super init]) {
		size = [theSize retain];
		fieldView = [[BSPlayFieldView alloc] initWithSize:size frame:CGRectMake(0.0f, 0.0f, 320.0f, 320.0f)];
		fieldView.controller = self;
		ships = [[NSMutableArray array] retain];
	}
	
	return self;
}

- (void)loadView {
	[super loadView];
	self.view = fieldView;
}

- (void)setSize:(BSViewSize)aSize position:(CGPoint)aPosition animated:(BOOL)animated {
	CGPoint diff = CGPointMake(aPosition.x - self.fieldView.frame.origin.x, aPosition.y - self.fieldView.frame.origin.y);
	
	CGFloat oldWidth = CGRectGetWidth(self.fieldView.frame);
	[self.fieldView animateToViewSize:aSize position:aPosition duration:1.5f];
	CGFloat prop = CGRectGetWidth(self.fieldView.frame) / oldWidth;

	for (BSShipController *ship in ships) {
		// We calculate the new position of the ship after the field has moved
		CGPoint newCoordinates = CGPointMake(ship.view.frame.origin.x + diff.x, ship.view.frame.origin.y + diff.y);
		CGPoint diffToGrid = CGPointMake(newCoordinates.x - self.fieldView.frame.origin.x, newCoordinates.y - self.fieldView.frame.origin.y);
		diffToGrid = CGPointMake(diffToGrid.x * prop, diffToGrid.y * prop);
		newCoordinates = CGPointMake(self.fieldView.frame.origin.x + diffToGrid.x, self.fieldView.frame.origin.y + diffToGrid.y);
		[ship.shipView animateToViewSize:aSize position:newCoordinates duration:1.5f];
	}
}


- (void)setOrigin:(CGPoint)position {
	[self.view.layer setPosition:position];
	[self.view setCenter:CGPointMake(self.view.center.x + (position.x - self.view.frame.origin.x), self.view.center.y + (position.y - self.view.frame.origin.y))];
	
	for (BSShipController *ship in ships) {
		[ship setCoordinate:position animated:NO];
	}
	
}

- (void)setTileSize:(CGFloat)aTileSize {
	CGFloat prop = aTileSize / fieldView.tileSize;
	fieldView.tileSize = aTileSize;
	
	for (BSShipController *ship in ships) {
		ship.tileSize = aTileSize;
	}
}

- (CGPoint)gridpointForCoordinate:(CGPoint)aPoint {
	CGPoint gridOffset = [self gridOffset];
	CGPoint gridpoint = CGPointMake(round((aPoint.x - gridOffset.x) / self.fieldView.tileSize), round((aPoint.y - gridOffset.y) / self.fieldView.tileSize));
	
	//NSLog(@"Gridp: %.2f / %.2f", gridpoint.x, gridpoint.y);
	return gridpoint;
}

- (CGPoint)coordinateForGridpoint:(CGPoint)aPoint {
	CGPoint gridOffset = [self gridOffset];
	NSLog(@"Grid Offset: %.2f / %.2f", gridOffset.x, gridOffset.y);
	CGPoint coordinates = CGPointMake(gridOffset.x + (aPoint.x * self.fieldView.tileSize), gridOffset.y + (aPoint.y * self.fieldView.tileSize));
	
	NSLog(@"%.2f / %.2f", coordinates.x, coordinates.y);
	
	return coordinates;
}

- (CGPoint)tileForCoordinate:(CGPoint)aPoint {
	CGPoint gridOffset = [self gridOffset];
	CGPoint tile = CGPointMake(floor((aPoint.x - gridOffset.x) / self.fieldView.tileSize), floor((aPoint.y - gridOffset.y) / self.fieldView.tileSize));
	
	return tile;
}

- (CGPoint)gridOffset {
	return CGPointMake(fieldView.frame.origin.x + fieldView.playField.frame.origin.x, fieldView.frame.origin.y + fieldView.playField.frame.origin.y);
}

- (void)setTileMarked:(CGPoint)tile {
	CGPoint tileCoordinates = [self coordinateForGridpoint:tile];
	
	UIView *overlay = [[UIView alloc] initWithFrame:CGRectMake(tileCoordinates.x, tileCoordinates.y, 30.0f, 30.0f)];
	overlay.backgroundColor = [UIColor blueColor];
	
	[self.fieldView addSubview:overlay];
}

// Checks if a gridpoint is really in the grid
- (BOOL)gridpointInGrid:(CGPoint)gridpoint {
	if (gridpoint.x > [size intValue] ||
		gridpoint.y > [size intValue] ||
		gridpoint.x < 0 ||
		gridpoint.y < 0) {
		return NO;
	}
	
	return YES;
}

// Checks if a coordinate is on the grid
- (BOOL)coordinateInGrid:(CGPoint)coordinate {
	return [self gridpointInGrid:[self gridpointForCoordinate:coordinate]];
}

- (BOOL)isShipInGrid:(BSShipController *)theShip {	
	if ([self gridpointForCoordinate:theShip.shipView.maxCoordinate].x > [size intValue] ||
		[self gridpointForCoordinate:theShip.shipView.maxCoordinate].y > [size intValue] ||
		[self gridpointForCoordinate:theShip.shipView.minCoordinate].x < 0 ||
		[self gridpointForCoordinate:theShip.shipView.minCoordinate].y < 0) {
		return NO;
	}
	
	return YES;
}

// Adds a ship to the field - and thus sets the delegate etc.
- (void)addShip:(BSShipController *)aShip {
	[ships addObject:[aShip retain]];
	[fieldView.superview addSubview:aShip.view];
	aShip.tileSize = fieldView.tileSize;
	aShip.delegate = self;
	aShip.playFieldController = self;
}

- (BOOL)shipsInGrid {
	if ([ships count] == 0) {
		[delegate playField:self allShipsInField:NO];
		return NO;
	}
		
	
	for (BSShipController *ship in ships) {
		if (![self isShipInGrid:ship]) {
			[delegate playField:self allShipsInField:NO];
			return NO;
		}
	}
	
	[delegate playField:self allShipsInField:YES];
	return YES;
}



# pragma mark BSPlayFieldViewDelegate Methods

- (void)fieldView:(id)field tappedAt:(CGPoint)aPoint {
	if (!touchEnabled) {
		return;
	}
	
	CGPoint tile = [self tileForCoordinate:aPoint];
	[self setTileMarked:tile];
}

# pragma mark BSShipDelegate Methods

- (void)ship:(id)aShip movedToPoint:(CGPoint)aPoint {
	[self shipsInGrid];
	
	[interactionDelegate playField:self ship:aShip movedToPoint:aPoint];
}

- (void)ship:(id)aShip rotatedToOrientation:(BSShipOrientation)anOrientation {
	
}

- (CGPoint)ship:(id)aShip pointToMoveForPoint:(CGPoint)aPoint {	
	BSShipController *theShip = (BSShipController *)aShip;
	
	NSLog(@"%.2f", theShip.shipView.maxCoordinate.x);
	
	if ([self gridpointForCoordinate:theShip.shipView.maxCoordinate].x > [size intValue] ||
		[self gridpointForCoordinate:theShip.shipView.maxCoordinate].y > [size intValue] ||
		[self gridpointForCoordinate:theShip.shipView.minCoordinate].x < 0 ||
		[self gridpointForCoordinate:theShip.shipView.minCoordinate].y < 0) {
		return aPoint;
	}
	
	return [self coordinateForGridpoint:[self gridpointForCoordinate:aPoint]];
}

- (BOOL)ship:(id)aShip shouldMoveToPoint:(CGPoint)aPoint {
	BSShipController *theShip = (BSShipController *)aShip;
	
	//NSLog(@"Next Point: %.2f / %.2f", aPoint.x, aPoint.y);
	
	CGRect nextFrame = CGRectMake(theShip.shipView.minCoordinate.x + (aPoint.x - theShip.shipView.minCoordinate.x), theShip.shipView.minCoordinate.y + (aPoint.y - theShip.shipView.minCoordinate.y),
									theShip.shipView.frame.size.width, theShip.shipView.frame.size.height);
	
	NSLog(@"%.2f / %.2f | %.2f / %.2f", CGRectGetMinX(nextFrame), CGRectGetMinY(nextFrame), CGRectGetMaxX(nextFrame), CGRectGetMaxY(nextFrame));
	
	// Just check that the leftmost / rightmost point is still in the parentView
	// And check that the topmost / lowermost point is still in the parentView
	//NSLog(@"Contained: %i", CGRectContainsRect([self.view superview].frame, nextFrame));
	if (CGRectContainsRect([self.view superview].frame, nextFrame)) {
		return YES;
	}
	
	return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}



@end
