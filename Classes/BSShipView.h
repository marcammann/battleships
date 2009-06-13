//
//  BSShipView.h
//  Battleships
//
//  Created by Marc Ammann on 3/28/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BSShipViewDelegate
- (void)ship:(id)aShip touchesStartedAt:(CGPoint)aPoint;
- (void)ship:(id)aShip touchesMovedFrom:(CGPoint)fromPoint to:(CGPoint)toPoint;
- (void)ship:(id)aShip touchesEndedAt:(CGPoint)aPoint;
- (void)ship:(id)aShip tappedAt:(CGPoint)aPoint;
@end


@interface BSShipView : UIView {
	CGPoint startTouchPosition;
	CGPoint currentTouchPosition;
	CGPoint stopTouchPosition;
	
	// The views ship controller
	id<BSShipViewDelegate> shipController;
	
	// The ships background image
	UIImage *image;
	
	// The ships virtual drag position (if it is on a grid, this still changes)
	CGPoint dragPosition;
	
	// The ships min and max coordinates. Literally means: left upper and right lower corner
	CGPoint minCoordinate;
	CGPoint maxCoordinate;
}

@property (nonatomic, readonly) CGPoint dragPosition;
@property (nonatomic, readonly) CGPoint minCoordinate;
@property (nonatomic, readonly) CGPoint maxCoordinate;

- (id)initWithFrame:(CGRect)aFrame controller:(id<BSShipViewDelegate>)aController;
- (void)resetDragPosition;


@end
