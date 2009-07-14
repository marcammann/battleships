//
//  BSShot.h
//  Baddleships
//
//  Created by Marc Ammann on 6/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	BSShotHitUnknown,
	BSShotHitYes,
	BSShotHitNo,
} BSShotHit;

typedef struct {
	CGPoint tile;
	BSShotHit hit;
	char sender[128];
	char receiver[128];
} shotInfo;

@interface BSShot : NSObject {
	// The shot tile
	CGPoint tile;
	
	// Hit or no Hit
	BSShotHit hit;
	
	// Sender and receiver of the shot
	id sender;
	id receiver;
}

@property (nonatomic, readwrite) CGPoint tile;
@property (nonatomic, readwrite) BSShotHit hit;
@property (nonatomic, assign) id sender;
@property (nonatomic, assign) id receiver;

- (NSData *)data;
- (id)initWithData:(NSData *)data;

@end
