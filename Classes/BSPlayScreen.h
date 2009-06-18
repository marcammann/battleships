//
//  BSPlayScreen.h
//  Baddleships
//
//  Created by Marc Ammann on 6/16/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

#import "BSShipView.h"
#import "BSPlayFieldView.h"
#import "BSPlayFieldController.h"
#import "BSCanvasView.h"

@interface BSPlayScreen : UIView {
	NSArray *ships;
	BSPlayFieldController *playFieldController;
	BSPlayFieldController *ownFieldController;
	
	BSCanvasView *canvas;
}



@end
