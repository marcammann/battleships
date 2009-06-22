//
//  BSSetupCPUSkillViewController.m
//  Baddleships
//
//  Created by Marc Ammann on 6/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BSSetupCPUSkillViewController.h"
#import "BSSetupCPUViewController.h"

@implementation BSSetupCPUSkillViewController

- (id)init {
	if (self = [super init]) {
		beginnerButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
		beginnerButton.frame = CGRectMake(0.0f, 0.0f, 250.0f, 40.0f);
		[beginnerButton setTitle:@"Beginner" forState:UIControlStateNormal];
		
		advancedButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
		advancedButton.frame = CGRectMake(0.0f, 0.0f, 250.0f, 40.0f);
		[advancedButton setTitle:@"Advanced" forState:UIControlStateNormal];
		
		[beginnerButton addTarget:self action:@selector(skillSelected:) forControlEvents:UIControlEventTouchUpInside];
		[advancedButton addTarget:self action:@selector(skillSelected:) forControlEvents:UIControlEventTouchUpInside];
	}
	
	return self;
}

- (void)loadView {
	[super loadView];
	
	beginnerButton.center = CGPointMake(CGRectGetMidY([[UIScreen mainScreen] applicationFrame]), CGRectGetMidX([[UIScreen mainScreen] applicationFrame]) - 30.0f);
	advancedButton.center = CGPointMake(CGRectGetMidY([[UIScreen mainScreen] applicationFrame]), CGRectGetMidX([[UIScreen mainScreen] applicationFrame]) + 30.0f);
	
	[self.view addSubview:beginnerButton];
	[self.view addSubview:advancedButton];
}

- (void)skillSelected:(id)sender {
	BSSetupCPUViewController *setupCPUController = [[BSSetupCPUViewController alloc] initWithSettings:nil];
	[self.navigationController pushViewController:setupCPUController animated:YES];
	[setupCPUController release];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
	[beginnerButton release];
	[advancedButton release];
    [super dealloc];
}


@end
