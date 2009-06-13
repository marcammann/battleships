//
//  BSShipController.m
//  Baddleships
//
//  Created by Marc Ammann on 6/6/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import "BSShipController.h"

#import "BSShipView.h"

@implementation BSShipController

@synthesize type;
@synthesize orientation;
@synthesize length;
@synthesize playFieldController;
@synthesize delegate;
@synthesize rotatable;
@synthesize movable;
@synthesize view;

- (id)initWithType:(BSShipType)theType {
	if (self = [super init]) {
		type = theType;
		view = [[BSShipView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 30.0f, 120.0f) controller:self];
	}
	
	return self;
}

- (void)dealloc {
	[length release];
	length = nil;
	[view release];
	
	[super dealloc];
}

- (void)loadView {
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

# pragma mark Accessor Methods

- (CGPoint)positionInGrid {
	return CGPointMake(0.0f, 0.0f);
}

# pragma mark Setters which trigger updates

// Sets the leftupper point to somewhere else
- (void)setCoordinate:(CGPoint)aPoint animated:(BOOL)animated {
	view.center = CGPointMake(view.center.x + (aPoint.x - view.frame.origin.x), view.center.y + (aPoint.y - view.frame.origin.y));
	[delegate ship:self movedToPoint:aPoint];
}

- (void)setType:(BSShipType)aType {
	type = aType;
	
	// TODO: Change the frame
}

- (void)setOrientation:(BSShipOrientation)anOrientation {
	orientation = anOrientation;
	
	CGAffineTransform oldTransform = view.transform;
	
	if (orientation == BSShipOrientationHorizontal) {
		view.transform = CGAffineTransformIdentity;
	} else {
		CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI/2.0f);
		view.transform = transform;
	}
	
	if ([delegate ship:self shouldMoveToPoint:view.minCoordinate]) {
		CGPoint point = [delegate ship:self pointToMoveForPoint:view.frame.origin];
		[self setCoordinate:point animated:NO];
	} else {
		view.transform = oldTransform;
	}
	
	[delegate ship:self rotatedToOrientation:orientation];
}

# pragma mark BSShipViewDelegate Methods

- (void)ship:(id)aShip touchesStartedAt:(CGPoint)aPoint {
	
}

- (void)ship:(id)aShip touchesMovedFrom:(CGPoint)fromPoint to:(CGPoint)toPoint {
	CGPoint diff = CGPointMake(fromPoint.x - toPoint.x,	fromPoint.y - toPoint.y);
	
	BSShipView *ship = (BSShipView *)aShip;
	
	NSLog(@"Diff: %.2f / %.2f", diff.x, diff.y);

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
