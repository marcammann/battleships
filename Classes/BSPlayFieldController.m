//
//  BSPlayFieldController.m
//  Baddleships
//
//  Created by Marc Ammann on 4/1/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import "BSPlayFieldController.h"
#import "BSShipView.h"

@implementation BSPlayFieldController

@synthesize view;

- (id)initWithSize:(NSNumber *)theSize frame:(CGRect)aFrame {
	if (self = [super init]) {
		size = [theSize retain];
		self.view = [[BSPlayFieldView alloc] initWithSize:size frame:aFrame];
		self.view.controller = self;
	}
	
	return self;
}

- (CGPoint)gridpointForCoordinate:(CGPoint)aPoint {
	CGPoint gridOffset = [self gridOffset];
	CGPoint gridpoint = CGPointMake(round((aPoint.x - gridOffset.x) / self.view.tileSize), round((aPoint.y - gridOffset.y) / self.view.tileSize));
	
	//NSLog(@"Gridp: %.2f / %.2f", gridpoint.x, gridpoint.y);
	return gridpoint;
}

- (CGPoint)coordinateForGridpoint:(CGPoint)aPoint {
	CGPoint gridOffset = [self gridOffset];
	NSLog(@"Grid Offset: %.2f / %.2f", gridOffset.x, gridOffset.y);
	CGPoint coordinates = CGPointMake(gridOffset.x + (aPoint.x * self.view.tileSize), gridOffset.y + (aPoint.y * self.view.tileSize));
	
	NSLog(@"%.2f / %.2f", coordinates.x, coordinates.y);
	
	return coordinates;
}

- (CGPoint)tileForCoordinate:(CGPoint)aPoint {
	CGPoint gridOffset = [self gridOffset];
	CGPoint tile = CGPointMake(floor((aPoint.x - gridOffset.x) / self.view.tileSize), floor((aPoint.y - gridOffset.y) / self.view.tileSize));
	
	return tile;
}

- (CGPoint)gridOffset {
	return CGPointMake(view.frame.origin.x + view.playField.frame.origin.x, view.frame.origin.y + view.playField.frame.origin.y);
}

- (void)setTileMarked:(CGPoint)tile {
	CGPoint tileCoordinates = [self coordinateForGridpoint:tile];
	
	UIView *overlay = [[UIView alloc] initWithFrame:CGRectMake(tileCoordinates.x, tileCoordinates.y, 30.0f, 30.0f)];
	overlay.backgroundColor = [UIColor blueColor];
	
	[self.view addSubview:overlay];
}

# pragma mark BSPlayFieldViewDelegate Methods

- (void)fieldView:(id)field tappedAt:(CGPoint)aPoint {
	if (!touchEnabled) {
		return;
	}
	
	CGPoint tile = [self tileForCoordinate:aPoint];
	[self setTileMarked:tile];
}

# pragma mark BSShipViewDelegate Methods

- (void)ship:(id)aShip movedToPoint:(CGPoint)aPoint {
	
}

- (void)ship:(id)aShip rotatedToOrientation:(BSShipOrientation)anOrientation {
	
}

- (CGPoint)ship:(id)aShip pointToMoveForPoint:(CGPoint)aPoint {	
	BSShipController *theShip = (BSShipController *)aShip;
	
	if ([self gridpointForCoordinate:theShip.view.maxCoordinate].x > [size intValue] ||
		[self gridpointForCoordinate:theShip.view.maxCoordinate].y > [size intValue] ||
		[self gridpointForCoordinate:theShip.view.minCoordinate].x < 0 ||
		[self gridpointForCoordinate:theShip.view.minCoordinate].y < 0) {
		return aPoint;
	}
	
	return [self coordinateForGridpoint:[self gridpointForCoordinate:aPoint]];
}

- (BOOL)ship:(id)aShip shouldMoveToPoint:(CGPoint)aPoint {
	BSShipController *theShip = (BSShipController *)aShip;
	
	//NSLog(@"Next Point: %.2f / %.2f", aPoint.x, aPoint.y);
	
	CGRect nextFrame = CGRectMake(theShip.view.minCoordinate.x + (aPoint.x - theShip.view.minCoordinate.x), theShip.view.minCoordinate.y + (aPoint.y - theShip.view.minCoordinate.y),
									theShip.view.frame.size.width, theShip.view.frame.size.height);
	
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
