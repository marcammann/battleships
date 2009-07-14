//
//  BSSetupScreen.h
//  Battleships
//
//  Created by Marc Ammann on 3/31/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import "BSShipView.h"
#import "BSPlayFieldView.h"
#import "BSPlayFieldController.h"
#import "BSCanvasView.h"

@interface BSSetupScreen : UIView <BSPlayFieldDisplayDelegate> {
	
	UIButton *helpButton;
	UIButton *continueButton;
	
	NSArray *ships;
	BSPlayFieldController *ownFieldController;
	
	BSCanvasView *canvas;
}

- (void)createShips;

@end
