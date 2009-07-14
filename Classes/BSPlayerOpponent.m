//
//  BSPlayerOpponent.m
//  Baddleships
//
//  Created by Marc Ammann on 7/13/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import "BSPlayerOpponent.h"


@implementation BSPlayerOpponent

@synthesize shootingField;
@synthesize displayName;

- (void)dealloc {
	[shootingField release];
	[displayName release];
	[super dealloc];
}

@end
