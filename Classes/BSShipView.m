//
//  BSShipView.m
//  Battleships
//
//  Created by Marc Ammann on 3/28/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import "BSShipView.h"
#import "Constants.h"


@implementation BSShipView

@synthesize size, dragPosition, fieldPosition;

CGFloat startAngle;

- (id)initWithSize:(NSInteger)theSize {
	CGFloat width = kTileSize * theSize;
	CGFloat height = kTileSize;
    if (self = [super initWithFrame:CGRectMake(0.0f, 0.0f, width, height)]) {
		self.size = theSize;
		self.dragPosition = self.center;
    }
	
    return self;
}

- (NSInteger)randomPivot {
	if (size % 2 == 1) {
		return size / 2;
	} else {
		return (size / 2) - (rand() % 2);
	}
}

- (void)drawRect:(CGRect)rect {
	self.backgroundColor = [UIColor blueColor];
}

- (void)dealloc {
    [super dealloc];
}


@end
