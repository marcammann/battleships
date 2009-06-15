//
//  BSSetupScreen.h
//  Battleships
//
//  Created by Marc Ammann on 3/31/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSShipView.h"
#import "BSPlayFieldView.h"
#import "BSPlayFieldController.h"
#import "BSCanvasView.h"

@interface BSSetupScreen : UIView {
	NSArray *ships;
	BSPlayFieldController *playFieldController;
	BSPlayFieldController *ownFieldController;
	
	BSCanvasView *canvas;
}

- (void)createShips;

@end
