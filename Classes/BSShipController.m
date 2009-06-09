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

- (void)setType {
	
}

- (void)setOrientation {
	
}

# pragma mark BSShipViewDelegate Methods

- (void)ship:(id)aShip touchesStartedAt:(CGPoint)aPoint {
	
}

- (void)ship:(id)aShip touchesMovedFrom:(CGPoint)fromPoint to:(CGPoint)toPoint {
	CGPoint diff = CGPointMake(fromPoint.x - toPoint.x,	fromPoint.y - toPoint.y);
	
	BSShipView *ship = (BSShipView *)aShip;
	[ship setCenter:CGPointMake(ship.center.x - diff.x, ship.center.y - diff.y)];
}

- (void)ship:(id)aShip touchesEndedAt:(CGPoint)aPoint {
	
}

- (void)ship:(id)aShip tappedAt:(CGPoint)aPoint {
	BSShipView *ship = (BSShipView *)aShip;
	
	CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI/2.0f);
	if (CGAffineTransformEqualToTransform(ship.transform, transform)) {
		ship.transform = CGAffineTransformIdentity;
	} else {
		ship.transform = transform;
	}
}


@end
