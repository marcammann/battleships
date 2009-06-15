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

@synthesize dragPosition;
@synthesize minCoordinate;
@synthesize maxCoordinate;


- (id)initWithFrame:(CGRect)aFrame controller:(id<BSShipViewDelegate>)aController {
	if (self = [super initWithFrame:aFrame]) {
		self.backgroundColor = [UIColor blueColor];
		shipController = aController;
	}
	
	return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = touches.anyObject;
	
	NSLog(@"touched");
	
	startTouchPosition = [touch locationInView:[self superview]];

	dragPosition = self.frame.origin;	
	
	[shipController ship:self touchesStartedAt:startTouchPosition];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = touches.anyObject;
	currentTouchPosition = [touch locationInView:[self superview]];
	CGPoint lastTouchPosition = [touch previousLocationInView:[self superview]];
	
	dragPosition = CGPointMake(dragPosition.x + (currentTouchPosition.x - lastTouchPosition.x), dragPosition.y + (currentTouchPosition.y - lastTouchPosition.y));
	
	[shipController ship:self touchesMovedFrom:lastTouchPosition to:currentTouchPosition];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = touches.anyObject;
	stopTouchPosition = [touch locationInView:[self superview]];
	currentTouchPosition = CGPointZero;
	
	if (touch.tapCount == 1) {
		[shipController ship:self tappedAt:stopTouchPosition];
	} else {
		[shipController ship:self touchesEndedAt:stopTouchPosition];
	}
	
	dragPosition = self.frame.origin;
	
	startTouchPosition = CGPointZero;
	stopTouchPosition = CGPointZero;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = touches.anyObject;
	stopTouchPosition = [touch locationInView:[self superview]];
	
	[shipController ship:self touchesEndedAt:stopTouchPosition];
}

- (CGPoint)minCoordinate {
	return CGPointMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame));
}

- (CGPoint)maxCoordinate {
	return CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame));	
}

- (void)resetDragPosition {
	dragPosition = [self minCoordinate];
}

@end
