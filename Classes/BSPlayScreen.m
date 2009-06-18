//
//  BSPlayScreen.m
//  Baddleships
//
//  Created by Marc Ammann on 6/16/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BSPlayScreen.h"


@implementation BSPlayScreen


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		canvas = [[BSCanvasView alloc] initWithFrame:frame];
		
		ownFieldController = [[BSPlayFieldController alloc] initWithSize:[NSNumber numberWithInt:10] frame:CGRectMake(325.0f, 0.0f, 128.0f, 128.0f)];
		//ownFieldController.delegate = self;
		
		playFieldController = [[BSPlayFieldController alloc] initWithSize:[NSNumber numberWithInt:10] frame:CGRectMake(0.0f, 0.0f, 320.0f, 320.0f)];
		playFieldController.delegate = self;
		
        // Initialization code
    }
    return self;
}



- (void)drawRect:(CGRect)rect {
	[canvas addSubview:ownFieldController];
	[canvas addSubview:playFieldController];
	
	[self addSubview:canvas];
}


- (void)dealloc {
    [super dealloc];
}


@end
