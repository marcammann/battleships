//
//  BSShipController.m
//  Baddleships
//
//  Created by Marc Ammann on 6/6/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import "BSShipController.h"

@implementation BSShipController

@synthesize type;
@synthesize orientation;
@synthesize length;
@synthesize playFieldController;
@synthesize delegate;
@synthesize rotatable;
@synthesize movable;
@synthesize view;

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

@end
