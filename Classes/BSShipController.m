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
#import <QuartzCore/QuartzCore.h>

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
@synthesize relativeCoordinates;
@synthesize tiles;


- (id)initWithType:(BSShipType)theType {
	if (self = [super init]) {
		type = theType;
		orientation = BSShipOrientationVertical;
		tileSize = 30.0f;
		length = [NSNumber numberWithInt:(type + 2)];
		
		tiles = [[NSMutableArray array] retain];
		
		self.shipView = [[BSShipView alloc] initWithTileSize:tileSize frame:CGRectMake(0.0f, 0.0f, tileSize, tileSize * [[NSNumber numberWithInt:type + 2] intValue]) controller:self];

		[self addObserver:self forKeyPath:@"self.shipView.center" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
		[self addObserver:self forKeyPath:@"self.shipView.frame" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
		[self addObserver:self forKeyPath:@"self.shipView.transform" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
	}
	
	return self;
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqual:@"self.shipView.center"] || [keyPath isEqual:@"self.shipView.frame"] || [keyPath isEqual:@"self.shipView.transform"]) {
		CGPoint gridpoint = [delegate gridpointForCoordinate:shipView.minCoordinate];
		if (gridpoint.x >= 0 && gridpoint.x < 10 && gridpoint.y >= 0 && gridpoint.y < 10) {
			position = gridpoint;
		} else {
			position = CGPointMake(-1.0f, -1.0f);
		}
		
		// Get Min/Max Coordinate tiles and iterate over them to get all the tiles the ship is using
		[self calculateTiles];
		
#ifdef _DEBUG
		NSLog(@"======== Ship Moved: ==========");
		NSLog(@"Type: %i", type);
		NSLog(@"Frame: x:%.2f y:%.2f / width:%.2f height:%.2f", shipView.frame.origin.x, shipView.frame.origin.y, shipView.frame.size.width, shipView.frame.size.height);
		NSLog(@"Tiles: ");
		for (NSValue *val in tiles) {
			NSLog(@"x:%.0f  y:%.0f", [val CGPointValue].x, [val CGPointValue].y);
		}
		NSLog(@"Position: x:%.0f y:%.0f", position.x, position.y);
		NSLog(@"===============================");
#endif
	} else {
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
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
	CGFloat prop = aTileSize / tileSize;
	
	tileSize = aTileSize;
	
	BSPlayFieldController *ctrl = (BSPlayFieldController *)playFieldController;
	self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width * prop, self.view.frame.size.height * prop);		
	[shipView setTileSize:aTileSize];
}

# pragma mark Accessor Methods

- (void)calculateTiles {
	CGPoint endPoint = [(BSPlayFieldController *)playFieldController calculateEndPointFromOriginForShip:self];
	CGPoint startPoint = [(BSPlayFieldController *)playFieldController gridpointForCoordinate:shipView.minCoordinate];
	
	[tiles removeAllObjects];
	
	for (int i = (int)startPoint.x; i <= (int)endPoint.x; i++) {
		if (i >= 10 || i < 0) { continue; }
		for (int j = (int)startPoint.y; j <= (int)endPoint.y; j++) {
			if (j >= 10 || i < 0) { continue; }
			[tiles addObject:[NSValue valueWithCGPoint:CGPointMake(i, j)]];
		}
	}
	
}

- (NSNumber *)length {
	length = [NSNumber numberWithInt:(type + 2)];
	return length;
}

- (CGPoint)positionInGrid {
	return CGPointMake(0.0f, 0.0f);
}

- (CGPoint)centerCoordinateForShipTile:(NSInteger)aTile {
	if (aTile >= [length intValue]) {
		//return CGPointMake(-1.0f, -1.0f);
	}
	
	
	CGPoint leftUpper = shipView.minCoordinate;
	CGPoint firstCenter = CGPointMake(leftUpper.x + tileSize/2, leftUpper.y + tileSize/2);
	
	CGPoint resCenter;
	if (orientation == BSShipOrientationHorizontal) {
		resCenter = CGPointMake(firstCenter.x + aTile * tileSize, firstCenter.y);
	} else {
		resCenter = CGPointMake(firstCenter.x, firstCenter.y + aTile * tileSize);
	}
	
	return resCenter;
}

# pragma mark Setters which trigger updates

// Sets the leftupper point to somewhere else
- (void)setCoordinate:(CGPoint)aPoint animated:(BOOL)animated {
	shipView.center = CGPointMake(shipView.center.x + (aPoint.x - shipView.minCoordinate.x), shipView.center.y + (aPoint.y - shipView.minCoordinate.y));
	[delegate ship:self movedToPoint:aPoint];
}

- (void)setCoordinateToPosition {
	CGPoint coordinate = [(BSPlayFieldController *)delegate coordinateForGridpoint:position];
	[self setCoordinate:coordinate animated:NO];
}

- (void)setType:(BSShipType)aType {
	type = aType;
	
	// TODO: Change the frame
}

- (void)setOrientation:(BSShipOrientation)anOrientation aroundAnchor:(CGPoint)anAnchor {
	CGPoint diff = CGPointMake(self.view.center.x - anAnchor.x, self.view.center.y - anAnchor.y);
	CGPoint newCenter = CGPointMake(anAnchor.x + diff.y, anAnchor.y + diff.x);


	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5f];
	if (anOrientation == BSShipOrientationVertical) {
		shipView.layer.transform = CATransform3DIdentity;
	} else {
		CATransform3D transform = CATransform3DMakeRotation(-M_PI/2.0f, 0.0f, 0.0f, 1.0f);
		shipView.layer.transform = transform;
	}
	
	orientation = anOrientation;
	shipView.center = newCenter;	
	CGPoint point = [delegate ship:self closestBoundaryPointForPoint:shipView.frame.origin];
	CGPoint validCenter = CGPointMake(point.x + (CGRectGetWidth(shipView.frame) / 2.0f), point.y + (CGRectGetHeight(shipView.frame) / 2.0f));
	shipView.center = validCenter;
	[UIView commitAnimations];
	
}

- (void)setOrientation:(BSShipOrientation)anOrientation {
	orientation = BSShipOrientationVertical;
	
	/*
	 CGAffineTransform oldTransform = shipView.transform;
	
	if (anOrientation == BSShipOrientationVertical) {
		shipView.transform = CGAffineTransformIdentity;
	} else {
		CGAffineTransform transform = CGAffineTransformMakeRotation(-M_PI/2.0f);
		shipView.transform = transform;
	}
	
	orientation = anOrientation;
	
	/*if ([delegate ship:self shouldMoveToPoint:shipView.minCoordinate]) {
		CGPoint point = [delegate ship:self pointToMoveForPoint:shipView.frame.origin];
		[self setCoordinate:point animated:NO];
		orientation = anOrientation;
	} else {
		shipView.transform = oldTransform;
	}*/
	
	
	//[delegate ship:self rotatedToOrientation:orientation];
	
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
	BSShipView *ship = (BSShipView *)aShip;
	CGPoint inShipCoordinate = [ship convertPoint:aPoint fromView:ship.superview];
	
	NSLog(@"In Ship Coordinate");
	CGLog(inShipCoordinate);
	
	NSInteger anchorTile;
	if (orientation == BSShipOrientationHorizontal) {
		inShipCoordinate = CGPointMake(inShipCoordinate.y, inShipCoordinate.x);
		anchorTile = (inShipCoordinate.x <= (CGRectGetWidth(ship.frame)/2)) ? 0 : ([self.length intValue] - 1);
	} else {
		anchorTile = (inShipCoordinate.y <= (CGRectGetHeight(ship.frame)/2)) ? 0 : ([self.length intValue] - 1);
	}
	
	NSLog(@"Anchor Tile");
	NSLog(@"%i", anchorTile);
	
	CGPoint anchorPoint = [self centerCoordinateForShipTile:anchorTile];
	BSShipOrientation newOrientation = (orientation == BSShipOrientationHorizontal) ? BSShipOrientationVertical : BSShipOrientationHorizontal;
	
	[self setOrientation:newOrientation aroundAnchor:anchorPoint];
}


@end
