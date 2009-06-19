//
//  BSPlayCPUViewController.m
//  Baddleships
//
//  Created by Marc Ammann on 6/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BSPlayCPUViewController.h"

@implementation BSPlayCPUViewController

- (id)init {
	if (self = [super init]) {
		canvas = [[BSCanvasView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 480.0f, 320.0f)];
		
		gameController = [[BSGameController alloc] init];
		
		ownPlayFieldController = [[BSPlayFieldController alloc] initWithSize:10 frame:CGRectMake(0.0f, 0.0f, 128.0f, 128.0f)];
		
		
	}
	
	return self;
}

- (void)loadView {
}

- (void)dealloc {
    [super dealloc];
}


@end
