//
//  BSShootingFieldController.m
//  Baddleships
//
//  Created by Marc Ammann on 6/22/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import "BSShootingFieldController.h"


@implementation BSShootingFieldController

@synthesize enemy;

- (id)initWithSize:(NSNumber *)theSize {
	if (self = [super init]) {
		size = [theSize retain];
		fieldView = [[BSPlayFieldView alloc] initWithSize:size frame:CGRectMake(0.0f, 0.0f, 320.0f, 320.0f)];
		fieldView.controller = self;
		ships = [[NSMutableArray array] retain];
		touchEnabled = YES;
	}
	
	return self;
}

- (void)dealloc {
	[enemy release];
	[super dealloc];
}

@end
