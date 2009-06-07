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
@end


@interface BSShipView : UIView {
	// The views ship controller
	id shipController;
	
	// The ships background image
	UIImage *image;
	
	// The ships virtual drag position (if it is on a grid, this still changes)
	CGPoint dragPosition;
}

@end
