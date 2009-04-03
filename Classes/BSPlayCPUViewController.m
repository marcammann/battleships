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


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[screen release];
    [super dealloc];
}


@end
