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
		player.windowDelegate = self;
		
		settings = [theSettings retain];
		ownPlayField = player.playField;
		shootingPlayField = [[BSShootingFieldController alloc] initWithSize:[NSNumber numberWithInt:10]];
		shootingPlayField.view.center = CGPointMake(-160.0f, 160.0f);
		shootingPlayField.view.alpha = 0.0f;
		shootingPlayField.touchEnabled = YES;
		shootingPlayField.interactionDelegate = player;
		shootingPlayField.enemy = player;
		player.shootingField = shootingPlayField;
	}
	
	return self;
}

- (void)loadView {
	[super loadView];
	[self.view addSubview:canvas];
	[canvas addSubview:player.playField.view];
	
	for (BSShipController *ship in player.playField.ships) {
		[canvas addSubview:ship.view];
	}
	
	[canvas addSubview:player.shootingField.view];
}

- (void)viewDidAppear:(BOOL)animated {
	[player.playField setSize:BSViewSizeSmall position:CGPointMake(330.0f, 0.0f) animated:YES];
	[player.shootingField setSize:BSViewSizeLarge position:CGPointMake(0.0f, 0.0f) animated:YES];
	[UIView beginAnimations:@"opacityAnimation" context:NULL];
	[UIView setAnimationDuration:1.5f];
	player.shootingField.view.alpha = 1.0f;
	[UIView commitAnimations];
}

- (void)dealloc {
    [super dealloc];
}

- (void)player:(id)aPlayer endedGame:(id)aGame withWinner:(id)aWinner {
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"You Win" message:@"You won the game" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

@end
