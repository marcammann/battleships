//
//  BSGameController.m
//  Baddleships
//
//  Created by Marc Ammann on 6/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BSGameController.h"


@implementation BSGameController

@synthesize players, shots;

- (void)addPlayer:(BSPlayerController *)player {
	[players addObject:player];
}

- (void)player:(id)aPlayer shotPlayer:(id)shotPlayer atTile:(CGPoint)tile {
	NSLog(@"YAYAY");
	
	
}

- (void)playerDidPauseGame:(id)aPlayer {
	
}

- (void)playerDidResumeGame:(id)aPlayer {
	
}

- (BOOL)playerCanPauseGame:(id)aPlayer {
	
}

- (void)playerDidQuitGame:(id)aPlayer {
	
}

@end
