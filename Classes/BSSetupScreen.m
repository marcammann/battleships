//
//  BSSetupScreen.m
//  Battleships
//
//  Created by Marc Ammann on 3/31/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import "BSSetupScreen.h"
#import "Constants.h"

#import "BSShipController.h"

@implementation BSSetupScreen

CGSize delayOffset;
BSShipView *currentShip;
NSTimeInterval touchStart;
BSShipController *ship;

BOOL rotating;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		//playFieldController = [[BSPlayFieldController alloc] initWithTilenumber:10];
		self.backgroundColor = [UIColor yellowColor];
		
		ship = [[BSShipController alloc] initWithType:BSShipType3];
		//[self createShips];
    }
    return self;
}

- (void)createShips {
	NSMutableArray *sizeCount = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], // Size 0
								 [NSNumber numberWithInt:0], // Size 1
								 [NSNumber numberWithInt:4], // Size 2
								 [NSNumber numberWithInt:3], // Size 3
								 [NSNumber numberWithInt:2], // Size 4
								 [NSNumber numberWithInt:1], nil]; // Size 5
	
	NSMutableArray *theShips = [NSMutableArray array];
	int j = 0;
	for (NSNumber *count in sizeCount) {
		for (int i = 0; i < [count integerValue]; i++) {
			BSShipView *aShip = [[BSShipView alloc] initWithSize:j];
			[theShips addObject:aShip];
		}
		j++;
	}
	
	ships = [[NSArray arrayWithArray:theShips] retain];
}

/*- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[event allTouches] anyObject];
	touchStart = touch.timestamp;

	delayOffset = CGSizeMake(0, 0);
	
	if ([ships containsObject:[touch view]] == NO) {
		return;
	}

	currentShip = (BSShipView *)[touch view];
	//currentShip.center = [touch locationInView:self];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	
	CGPoint prevPointInView = [touch previousLocationInView:self];
	CGPoint pointInView = [touch locationInView:self];	
	//NSLog(@"%i", touch.tapCount);
	
	if (touch.timestamp - touchStart < kTapDelay) {
		delayOffset.width += prevPointInView.x - pointInView.x;
		delayOffset.height += prevPointInView.y - pointInView.y;
		return;
	}
	
	if (currentShip != nil) {
		currentShip.dragPosition = CGPointMake(pointInView.x - (prevPointInView.x - currentShip.dragPosition.x) - delayOffset.width, pointInView.y - (prevPointInView.y - currentShip.dragPosition.y) - delayOffset.height);
		currentShip.center = currentShip.dragPosition;
		if ([playFieldController isShipInField:currentShip]) {
			
			[playFieldController placeShipInField:currentShip];
		}
		
		
		delayOffset = CGSizeMake(0.0f, 0.0f);
	}
}
/*
 UITouch *touch = [touches anyObject];
 
 CGPoint posInShip = [touch previousLocationInView:self];
 CGPoint posInSuper = [touch locationInView:self.superview];
 
 CGPoint posOffset = CGPointMake(posInShip.x - self.realPos.x, posInShip.y - self.realPos.y);
 
 CGPoint newPos = CGPointMake(posInSuper.x - posInShip.x + posOffset.x, posInSuper.y - posInShip.y + posOffset.y);
 
 if (newPos.x < 20.0f) {
 newPos.x = 20.0f;
 }
 
 if (newPos.y < 20.0f) {
 newPos.y = 20.0f;
 }
 
 if (newPos.y + 30.0f > 320.0f) {
 newPos.y = 290.0f;
 }
 
 
 NSLog(@"%.2f, %.2f / %.2f, %.2f => %.2f, %.2f", posInShip.x, posInShip.y, self.realPos.x, self.realPos.y, newPos.x, newPos.y);
 
 if (newPos.x < 184.0f) {
 CGPoint tmpPos = CGPointMake(newPos.x - 20.0f, newPos.y - 20.0f);
 int fieldX = round(tmpPos.x / 30.0f);
 int fieldY = round(tmpPos.y / 30.0f);
 
 NSLog(@"New Field: %i, %i", fieldX, fieldY);
 newPos.x = (fieldX * 30.0f) + 20.0f;
 newPos.y = (fieldY * 30.0f) + 20.0f;
 }
 
 ship.frame =  CGRectMake(newPos.x, newPos.y, self.frame.size.width, self.frame.size.height);

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	//NSLog(@"%i - %i", [touches.allObjects count], [[[event allTouches] allObjects] count]);
	
	UITouch *touch = [touches anyObject];
	if (touch.timestamp - touchStart < kTapDelay && currentShip != nil) {
		CGAffineTransform t = CGAffineTransformConcat(currentShip.transform, CGAffineTransformMakeRotation(-M_PI/2));
		[currentShip setTransform:t];
		//[playFieldController placeShipInField:currentShip];
	}
	
	if ((CGRectGetMinX(currentShip.frame) < 0 ||
		CGRectGetMinY(currentShip.frame) < 0 ||
		CGRectGetMaxY(currentShip.frame) > 320.0f)) {
		[playFieldController placeShipInField:currentShip];
	}

	
	//currentShip.dragPosition = currentShip.center;
	currentShip = nil;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	
}

*/
- (void)drawRect:(CGRect)rect {
	[self addSubview:playFieldController.view];
	[self addSubview:ship.view];
}


- (void)dealloc {
    [super dealloc];
}


@end
