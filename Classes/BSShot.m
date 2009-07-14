//
//  BSShot.m
//  Baddleships
//
//  Created by Marc Ammann on 6/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BSShot.h"
#import "BSPlayerOpponent.h"

@implementation BSShot

@synthesize hit;
@synthesize tile;
@synthesize sender;
@synthesize receiver;

- (id)initWithData:(NSData *)aData {
	
}

- (void *)data {
	shotInfo *info = (shotInfo *)malloc(sizeof(shotInfo));
	info->tile = tile;
	info->hit = hit;
	info->senderID = [(BSPlayerOpponent *)sender playerID];
	info->receiverID = [(BSPlayerOpponent *)receiver playerID];
	
	return info;
}

@end
