//
//  BSPlayCPUViewController.m
//  Battleships
//
//  Created by Marc Ammann on 3/28/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import "BSPlayCPUViewController.h"


@implementation BSPlayCPUViewController

- (id)init {
	if (self = [super init]) {
		screen = [[BSSetupScreen alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 480.0f, 320.0f)];
	}
	
	return self;
}


- (void)loadView {
	[super loadView];
	[self.view addSubview:screen];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


- (void)dealloc {
	[screen release];
    [super dealloc];
}


@end
