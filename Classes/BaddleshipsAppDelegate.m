//
//  BaddleshipsAppDelegate.m
//  Baddleships
//
//  Created by Marc Ammann on 3/31/09.
//  Copyright Codesofa 2009. All rights reserved.
//

#import "BaddleshipsAppDelegate.h"

@implementation BaddleshipsAppDelegate

@synthesize window, baseContainer;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	[application setStatusBarHidden:YES];
	
	baseContainer = [[BSStartViewController alloc] init];
	
	UINavigationController *baseNavigation = [[UINavigationController alloc] initWithRootViewController:baseContainer];
	[baseNavigation setNavigationBarHidden:YES];
	
	[window addSubview:baseNavigation.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
	[baseContainer release];
    [window release];
    [super dealloc];
}


@end
