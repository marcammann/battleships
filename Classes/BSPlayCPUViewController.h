//
//  BSPlayCPUViewController.h
//  Baddleships
//
//  Created by Marc Ammann on 6/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSGameController.h"
#import "BSPlayFieldController.h"
#import "BSShipController.h"
#import "BSCanvasView.h"

@interface BSPlayCPUViewController : UIViewController {
	// The current game controller
	BSGameController *gameController;
	
	// The players play field, in small
	BSPlayFieldController *ownPlayFieldController;
	
	// The canvas
	BSCanvasView *canvas;
}

@end
