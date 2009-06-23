//
//  BSShot.h
//  Baddleships
//
//  Created by Marc Ammann on 6/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BSShot : NSObject {
	// The shot tile
	CGPoint tile;
	
	// Hit or no Hit
	BOOL hit;
	
	// Sender and receiver of the shot
	id sender;
	id receiver;
}

@property (nonatomic, readwrite) CGPoint tile;
@property (nonatomic, readwrite) BOOL hit;
@property (nonatomic, assign) id sender;
@property (nonatomic, assign) id receiver;

@end
