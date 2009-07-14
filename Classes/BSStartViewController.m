//
//  BSContainerViewController.m
//  Battleships
//
//  Created by Marc Ammann on 3/28/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import "BSStartViewController.h"

#define kStartButtonWidth 200.0f
#define kStartButtonHeight 50.0f

@implementation BSStartViewController

- (id)init {
	if (self = [super init]) {
		vsCpuButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		vsPlayerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		vsNetworkButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		settingsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[self.view addSubview:vsCpuButton];
		[self.view addSubview:vsPlayerButton];
		[self.view addSubview:vsNetworkButton];
		[self.view addSubview:settingsButton];
	}
	
	return self;
}


- (void)loadView {
	[super loadView];
	CGFloat buttonXPos = self.view.frame.size.height/2 - kStartButtonWidth/2;

	CGFloat buttonYPos = 50.0f;
	vsCpuButton.frame = CGRectMake(buttonXPos, buttonYPos, kStartButtonWidth, kStartButtonHeight);
	[vsCpuButton setTitle:@"vs. CPU" forState:UIControlStateNormal];
	[vsCpuButton addTarget:self action:@selector(loadCPUGame) forControlEvents:UIControlEventTouchUpInside];
	
	buttonYPos += kStartButtonHeight + 10.0f;
	vsPlayerButton.frame = CGRectMake(buttonXPos, buttonYPos, kStartButtonWidth, kStartButtonHeight);
	[vsPlayerButton setTitle:@"vs. Network Server" forState:UIControlStateNormal];
	[vsPlayerButton addTarget:self action:@selector(loadNetworkGameServer) forControlEvents:UIControlEventTouchUpInside];
	
	buttonYPos += kStartButtonHeight + 10.0f;
	vsNetworkButton.frame = CGRectMake(buttonXPos, buttonYPos, kStartButtonWidth, kStartButtonHeight);
	[vsNetworkButton setTitle:@"vs. Network" forState:UIControlStateNormal];
	[vsNetworkButton addTarget:self action:@selector(loadNetworkGame) forControlEvents:UIControlEventTouchUpInside];
	
	
	
	buttonYPos += kStartButtonHeight + 10.0f;
	settingsButton.frame = CGRectMake(buttonXPos, buttonYPos, kStartButtonWidth, kStartButtonHeight);
}

- (void)loadCPUGame {
	BSSetupCPUSkillViewController *viewController = [[BSSetupCPUSkillViewController alloc] init];
	[self.navigationController pushViewController:viewController animated:YES];
	[viewController release];
}

- (void)loadNetworkGame {
	BSSetupNetworkPeerViewController *viewController = [[BSSetupNetworkPeerViewController alloc] initAsServer:NO];
	[self.navigationController pushViewController:viewController animated:YES];
	[viewController release];
}

- (void)loadNetworkGameServer {
	BSSetupNetworkPeerViewController *viewController = [[BSSetupNetworkPeerViewController alloc] initAsServer:YES];
	[self.navigationController pushViewController:viewController animated:YES];
	[viewController release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
