//
//  BSShipController.m
//  Baddleships
//
//  Created by Marc Ammann on 6/6/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import "BSShipController.h"
#import "BSPlayFieldController.h"
#import "BSShipView.h"

@implementation BSShipController

@synthesize type;
@synthesize orientation;
@synthesize length;
@synthesize playFieldController;
@synthesize delegate;
@synthesize rotatable;
@synthesize movable;
@synthesize shipView;
@synthesize position;
@synthesize tileSize;

- (id)initWithType:(BSShipType)theType {
	if (self = [super init]) {
		type = theType;
		orientation = BSShipOrientationVertical;
		tileSize = 30.0f;
		
		self.shipView = [[BSShipView alloc] initWithTileSize:tileSize frame:CGRectMake(0.0f, 0.0f, tileSize, tileSize * [[NSNumber numberWithInt:type + 2] intValue]) controller:self];
	}
	
	return self;
}

- (void)dealloc {
	[length release];
	length = nil;
	[shipView release];
	
	[super dealloc];
}

- (void)loadView {
	[super loadView];
	self.view = shipView;
	//[self.view addSubview:shipView];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)setTileSize:(CGFloat)aTileSize {
	tileSize = aTileSize;
	
	[shipView setTileSize:aTileSize];
}

# pragma mark Accessor Methods

- (NSNumber *)length {
	return [NSNumber numberWithInt:(type + 2)];
}

- (CGPoint)positionInGrid {
	return CGPointMake(0.0f, 0.0f);
}

# pragma mark Setters which trigger updates

// Sets the leftupper point to somewhere else
- (void)setCoordinate:(CGPoint)aPoint animated:(BOOL)animated {
	shipView.center = CGPointMake(shipView.center.x + (aPoint.x - shipView.minCoordinate.x), shipView.center.y + (aPoint.y - shipView.minCoordinate.y));
	[delegate ship:self movedToPoint:aPoint];
	CGPoint gridpoint = [delegate gridpointForCoordinate:shipView.minCoordinate];
	if (gridpoint.x >= 0 && gridpoint.x < 10 && gridpoint.y >= 0 && gridpoint.y < 10) {
		position = gridpoint;
		NSLog(@"Position: %.2f / %.2f", position.x, position.y);
	}
}

- (void)setCoordinateToPosition {
	CGPoint coordinate = [(BSPlayFieldController *)delegate coordinateForGridpoint:position];
	[self setCoordinate:coordinate animated:NO];
}

- (void)setType:(BSShipType)aType {
	type = aType;
	
	// TODO: Change the frame
}

- (void)setOrientation:(BSShipOrientation)anOrientation {
		
	CGAffineTransform oldTransform = shipView.transform;
	
	if (anOrientation == BSShipOrientationVertical) {
		shipView.transform = CGAffineTransformIdentity;
	} else {
		CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI/2.0f);
		shipView.transform = transform;
	}
	
	orientation = anOrientation;
	
	/*if ([delegate ship:self shouldMoveToPoint:view.minCoordinate]) {
		CGPoint point = [delegate ship:self pointToMoveForPoint:view.frame.origin];
		[self setCoordinate:point animated:NO];
		orientation = anOrientation;
	} else {
		view.transform = oldTransform;
	}*/
	
	
	
	[delegate ship:self rotatedToOrientation:orientation];
}

# pragma mark BSShipViewDelegate Methods

- (void)ship:(id)aShip touchesStartedAt:(CGPoint)aPoint {
	
}

- (void)ship:(id)aShip touchesMovedFrom:(CGPoint)fromPoint to:(CGPoint)toPoint {
	CGPoint diff = CGPointMake(fromPoint.x - toPoint.x,	fromPoint.y - toPoint.y);
	
	BSShipView *ship = (BSShipView *)aShip;
	
	//NSLog(@"Diff: %.2f / %.2f", diff.x, diff.y);

	CGPoint leftUpper = CGPointMake(ship.minCoordinate.x - diff.x, ship.minCoordinate.y - diff.y);
	if (![delegate ship:self shouldMoveToPoint:leftUpper]) {
		[ship resetDragPosition];
		return;
	}
	
	CGPoint point = [delegate ship:self pointToMoveForPoint:ship.dragPosition];
	
	if ([delegate ship:self shouldMoveToPoint:point]) {
		[self setCoordinate:point animated:NO];
	} else {
		[ship resetDragPosition];
		return;
	}
}

- (void)ship:(id)aShip touchesEndedAt:(CGPoint)aPoint {
	
}

- (void)ship:(id)aShip tappedAt:(CGPoint)aPoint {
	BSShipOrientation newOrientation = (orientation == BSShipOrientationHorizontal) ? BSShipOrientationVertical : BSShipOrientationHorizontal;
	
	[self setOrientation:newOrientation];
}


@end
