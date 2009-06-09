//
//  BSShipView.m
//  Battleships
//
//  Created by Marc Ammann on 3/28/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import "BSShipView.h"
#import "Constants.h"

@interface BSShipView (private)
CGPoint startTouchPosition;
CGPoint currentTouchPosition;
CGPoint stopTouchPosition;
@end


@implementation BSShipView

- (id)initWithFrame:(CGRect)aFrame controller:(id<BSShipViewDelegate>)aController {
	if (self = [super initWithFrame:aFrame]) {
		self.backgroundColor = [UIColor blueColor];
		shipController = aController;
	}
	
	return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = touches.anyObject;
	startTouchPosition = [touch locationInView:[self superview]];
	
	dragPosition = startTouchPosition;
	
	[shipController ship:self touchesStartedAt:startTouchPosition];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = touches.anyObject;
	currentTouchPosition = [touch locationInView:[self superview]];
	
	dragPosition = currentTouchPosition;
	
	[shipController ship:self touchesMovedFrom:[touch previousLocationInView:[self superview]] to:currentTouchPosition];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = touches.anyObject;
	stopTouchPosition = [touch locationInView:[self superview]];
	
	dragPosition = stopTouchPosition;
	
	if (touch.tapCount == 1) {
		[shipController ship:self tappedAt:stopTouchPosition];
	} else {
		[shipController ship:self touchesEndedAt:stopTouchPosition];
	}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = touches.anyObject;
	stopTouchPosition = [touch locationInView:[self superview]];
	
	[shipController ship:self touchesEndedAt:stopTouchPosition];
}

@end
