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
@synthesize randomShips;
@synthesize interactionDelegate;
@synthesize ships;
@synthesize touchEnabled;

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


- (BOOL)isTileAssigned:(CGPoint)tile {
	NSMutableDictionary *dict;
	
}



# pragma mark BSPlayFieldViewDelegate Methods

- (void)fieldView:(id)field tappedAt:(CGPoint)aPoint {
	if (!touchEnabled) {
		return;
	}
	
	CGPoint tile = [self tileForCoordinate:aPoint];
	[self setTileMarked:tile];
	[interactionDelegate playField:self tappedAt:aPoint];
	
	
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

# pragma mark RandomPlayField methods

- (CGPoint)generateRandonCoordinates {
	// Create random coordinates (inside the play field!)
	CGPoint originPoint = CGPointMake((1 + arc4random()) % kPlayFieldNumberOfTiles, (1 + arc4random()) % kPlayFieldNumberOfTiles);	
	return originPoint;
}

- (CGPoint)calculateEndPointFromOriginForShip:(BSShipController *)aShip {
	CGPoint endPoint = (aShip.orientation == BSShipOrientationHorizontal) ? CGPointMake(aShip.position.x + [aShip.length integerValue], aShip.position.y) : CGPointMake(aShip.position.x, aShip.position.y + [aShip.length integerValue]);
	return endPoint;
}

- (BOOL)areShipsInteresectingIfShipOneOrig:(CGPoint)pointA shipOneEnd:(CGPoint)pointB 
								shipTwoOrig:(CGPoint)pointC shipTwoEnd:(CGPoint)pointD {
	// Ship one line equations
	float kAOne = pointB.y - pointA.y;
	float kBOne = pointA.x - pointB.x;
	//UInt32 kCOne = (kAOne * pointA.x) + (kBOne * pointA.y);
	
	// Ship two line equations
	float kATwo = pointD.y - pointC.y;
	float kBTwo = pointC.x - pointD.x;
	//UInt32 kCTwo = (kATwo * pointC.x) + (kBTwo * pointC.y);
	
	// Determinant
	float determinant = (kAOne * kBTwo) - (kATwo * kBOne);
	NSLog(@"+++++++ DETERMINANT: %f", determinant);
	
	if (determinant == 0) return NO;
	else return YES;		
}

- (void)createRandomPlayField:(NSArray *)theShips  {
	UInt32 shipsCount = 0;
	NSMutableArray *candidateShips = [[NSMutableArray alloc] init];
	
	for (BSShipController *aShip in theShips) {
		// Create random orientation
		UInt8 randomOrientation = (1 + arc4random()) % 2;
		[aShip setOrientation:randomOrientation];
		
		// Create random coordinates (inside the play field!)	
		CGPoint randomOrigin = [self generateRandonCoordinates];
		[aShip setCoordinate:[self coordinateForGridpoint:randomOrigin] animated:NO];
		CGPoint randomEnd = [self calculateEndPointFromOriginForShip:aShip];

		// Ship has to be inside play field
		while (randomEnd.x > kPlayFieldNumberOfTiles  || randomEnd.y > kPlayFieldNumberOfTiles) {
			randomOrigin = [self generateRandonCoordinates];
			[aShip setCoordinate:[self coordinateForGridpoint:randomOrigin] animated:NO];
			randomEnd = [self calculateEndPointFromOriginForShip:aShip];
			NSLog(@"****** One more time! *****");
		}
		


		// We always want first ship 
		if ([candidateShips count] == 0) {
			[aShip setCoordinate:[self coordinateForGridpoint:randomOrigin] animated:NO];
			[candidateShips addObject:aShip];
			NSLog(@"???????????????????");
		}
		else {
			for (BSShipController *otherShip in candidateShips) {
				BOOL areShipsIntersecting = [self areShipsInteresectingIfShipOneOrig:otherShip.position shipOneEnd:[self calculateEndPointFromOriginForShip:otherShip] 
																		 shipTwoOrig:aShip.position shipTwoEnd:[self calculateEndPointFromOriginForShip:aShip]];
				if (areShipsIntersecting) {			
					CGPoint randomOrigin = [self generateRandonCoordinates];
					[aShip setCoordinate:[self coordinateForGridpoint:randomOrigin] animated:NO];
					CGPoint randomEnd = [self calculateEndPointFromOriginForShip:aShip];
					
					while (randomEnd.x > kPlayFieldNumberOfTiles  || randomEnd.y > kPlayFieldNumberOfTiles) {
						randomOrigin = [self generateRandonCoordinates];
						[aShip setCoordinate:[self coordinateForGridpoint:randomOrigin] animated:NO];
						randomEnd = [self calculateEndPointFromOriginForShip:aShip];
						NSLog(@"****** Again one more tiiiiimee! *****");
					}
					areShipsIntersecting = [self areShipsInteresectingIfShipOneOrig:otherShip.position shipOneEnd:[self calculateEndPointFromOriginForShip:otherShip] 
																		shipTwoOrig:aShip.position shipTwoEnd:[self calculateEndPointFromOriginForShip:aShip]];
				}
			}

			
			[aShip setCoordinate:[self coordinateForGridpoint:randomOrigin] animated:NO];
			[candidateShips addObject:aShip];
			NSLog(@"!!!!!!!!!!!!!!!!!!!");
		}
			
		
		NSLog(@"=================== shipsCount: %d", shipsCount);
		NSLog(@"**CandidateShips.count: %d", [candidateShips count] );
		NSLog(@"**Origin:   %.2f, %.2f", aShip.position.x, randomOrigin.y);
		NSLog(@"**End:      %.2f, %.2f", randomEnd.x, randomEnd.y);
		NSLog(@"**Type:     %d", aShip.type);
		NSLog(@"**Length:   %d", [aShip.length integerValue]);
		NSLog(@"**Orient:   %d", aShip.orientation);	
		shipsCount++;
		

	}
	
	randomShips = [[NSArray arrayWithArray:candidateShips] retain];

	[candidateShips release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}



@end
