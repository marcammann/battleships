//
//  BSPlayCPUViewController.m
//  Baddleships
//
//  Created by Marc Ammann on 6/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BSPlayCPUViewController.h"

@implementation BSPlayCPUViewController

- (id)initWithGame:(BSGameController *)aGame player:(BSPlayerControllerHuman *)aPlayer settings:(BSSettings *)theSettings {
	if (self = [super init]) {
		canvas = [[BSCanvasView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 480.0f, 320.0f)];
		canvas.backgroundColor = [UIColor purpleColor];
		
		game = [aGame retain];
		player = [aPlayer retain];
		player.interactionDelegate = game;
		
		settings = [theSettings retain];
		ownPlayField = player.playField;
		shootingPlayField = [[BSShootingFieldController alloc] initWithSize:[NSNumber numberWithInt:10]];
		shootingPlayField.view.center = CGPointMake(-160.0f, 160.0f);
		shootingPlayField.view.alpha = 0.0f;
		shootingPlayField.touchEnabled = YES;
		shootingPlayField.interactionDelegate = player;
		shootingPlayField.enemy = player;
	}
	
	return self;
}

- (void)loadView {
	[super loadView];
	[self.view addSubview:canvas];
	[canvas addSubview:ownPlayField.view];
	
	for (BSShipController *ship in ownPlayField.ships) {
		[canvas addSubview:ship.view];
	}
	
	[canvas addSubview:shootingPlayField.view];
}

- (void)viewDidAppear:(BOOL)animated {
	[ownPlayField setSize:BSViewSizeSmall position:CGPointMake(330.0f, 0.0f) animated:YES];
	[shootingPlayField setSize:BSViewSizeLarge position:CGPointMake(0.0f, 0.0f) animated:YES];
	[UIView beginAnimations:@"opacityAnimation" context:NULL];
	[UIView setAnimationDuration:1.5f];
	shootingPlayField.view.alpha = 1.0f;
	[UIView commitAnimations];
}

- (void)dealloc {
    [super dealloc];
}


@end
