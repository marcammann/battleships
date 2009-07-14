//
//  BSPlayerControllerHuman.m
//  Baddleships
//
//  Created by Marc Ammann on 6/22/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import "BSPlayerControllerHuman.h"
#import "BSShootingFieldController.h"

@implementation BSPlayerControllerHuman

- (void)playField:(id)aField tappedAt:(CGPoint)aPoint {
	BSShootingFieldController *shootingField = (BSShootingFieldController *)aField;
	[interactionDelegate player:self shotPlayer:shootingField.enemy atTile:[shootingField tileForCoordinate:aPoint]];
}

@end
