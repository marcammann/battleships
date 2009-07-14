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
	int senderID;
	int receiverID;
	CGPoint tile;
	BSShotHit hit;
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

- (void *)data;
- (id)initWithData:(NSData *)data;

@end
