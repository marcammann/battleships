//
//  BSPlayFieldController.m
//  Baddleships
//
//  Created by Marc Ammann on 4/1/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import "BSPlayFieldController.h"


@implementation BSPlayFieldController

@synthesize view;

- (id)initWithTilenumber:(NSInteger)theTilesCount {
	if (self = [super init]) {
		tilesCount = theTilesCount;
		self.view = [[BSPlayFieldView alloc] initWithTilenumber:tilesCount];
	}
	
	return self;
}

- (void)placeShipInField:(BSShipView *)ship  {
	CGPoint blockPoint = [self blockPointForPoint:ship.frame.origin];
	//NSLog(@"%i", blockPoint.x);
	ship.center = CGPointMake(blockPoint.x + CGRectGetWidth(ship.frame)/2, blockPoint.y + CGRectGetHeight(ship.frame)/2);
	
	while (CGRectGetMaxX(ship.frame) > CGRectGetMaxX(self.view.frame)) {
		ship.center = CGPointMake(ship.center.x - kTileSize, ship.center.y);
	}
	
	while (CGRectGetMaxY(ship.frame) > CGRectGetMaxY(self.view.frame)) {
		ship.center = CGPointMake(ship.center.x, ship.center.y - kTileSize);
	}
}

- (void)randomPlaceShipInField:(BSShipView *)ship {
	
}

- (NSInteger)horizontalSpaceForBlock:(BSPlayFieldBlock *)block {
	
}

- (NSInteger)verticalSpaceForBlock:(BSPlayFieldBlock *)block {
	
}

- (BSPlayFieldBlock *)blockForElement:(NSInteger)element inShip:(BSShipView *)ship {
	if (![self isShipInField:ship]) {
		return nil;
	}
	
	
}

- (CGPoint)blockPointForPoint:(CGPoint)point {
	CGFloat fieldOffsetX = 20.0f;
	CGFloat fieldOffsetY = 20.0f;
	
	CGFloat distX = point.x - fieldOffsetX;
	CGFloat distY = point.y - fieldOffsetY;
	
	NSInteger tileX = round(distX / kTileSize);
	NSInteger tileY = round(distY / kTileSize);
	
	//NSLog(@"%i / %i", tileX, tileY);
	
	if (tileX < 0) {
		tileX = 0;
	}
	if (tileY < 0) {
		tileY = 0;
	}
	
	if (tileX >= tilesCount) {
		tileX == tilesCount - 1;
	}
	if (tileY >= tilesCount) {
		tileY == tilesCount - 1;
	}
	
	NSLog(@"Foo");
	CGPoint result = CGPointMake(fieldOffsetX + tileX * kTileSize, fieldOffsetY + tileY * kTileSize);
	NSLog(@"Point %.2f / %.2f", result.x, result.y);
	return result;
}

- (BOOL)isShipInField:(BSShipView *)ship {
	CGFloat maxX = CGRectGetMaxX(ship.frame);
	CGFloat maxY = CGRectGetMaxY(ship.frame);
	
	if ((maxX - kTileSize/2.0f) < CGRectGetMaxX(self.view.frame) &&
		(maxY - kTileSize/2.0f) < CGRectGetMaxY(self.view.frame)) {
		return YES;
	} else {
		return NO;
	}
}

- (CGFloat)offsetHorzontalForShip:(BSShipView *)ship {
	CGFloat playFieldStart = CGRectGetMinX([(BSPlayFieldView *)self.view playField].frame);
	CGFloat shipStart = CGRectGetMinX(ship.frame);
	return (shipStart - playFieldStart);
}


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[view release];
    [super dealloc];
}


@end
