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
@synthesize tileSize;

- (id)initWithTileSize:(CGFloat)aTileSize frame:(CGRect)aFrame controller:(id<BSShipViewDelegate>)aController {
	if (self = [super initWithFrame:aFrame]) {
		self.backgroundColor = [UIColor blueColor];
		shipController = aController;
		tileSize = aTileSize;
	}
	
	return self;
}

- (void)animateToViewSize:(BSViewSize)aSize position:(CGPoint)position duration:(CGFloat)duration {
	[UIView beginAnimations:@"shipAnimation" context:NULL];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];	
	
	CGFloat tmpTileSize = (aSize == BSViewSizeSmall) ? kSmallTileSize : kTileSize;
	CGFloat prop = tmpTileSize / kTileSize;
	CGSize newSize = CGSizeMake((self.frame.size.width / tileSize) * kTileSize, (self.frame.size.height / tileSize) * kTileSize);
	
	
	[self setTileSize:tmpTileSize];
	self.frame = CGRectMake(position.x, position.y, newSize.width * prop, newSize.height * prop);
	[UIView commitAnimations];
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
	CGFloat prop = tileSize / kTileSize;
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, (self.frame.size.width/tileSize) * kTileSize * prop, (self.frame.size.height/tileSize) * kTileSize * prop);
}

- (void)setTileSize:(CGFloat)aTileSize {
	tileSize = aTileSize;
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
