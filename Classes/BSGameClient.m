//
//  BSGameClient.m
//  Baddleships
//
//  Created by Marc Ammann on 7/13/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import "BSGameClient.h"


@implementation BSGameClient

@synthesize session;
@synthesize peerID;
@synthesize player;

- (id)initWithSession:(GKSession *)aSession peerID:(NSString *)aPeerID {
	if (self = [super init]) {
		session = [aSession retain];
		peerID = [aPeerID retain];
		
		[session setDataReceiveHandler:self withContext:nil];
		session.delegate = self;
	}
	
	return self;
}

- (NSArray *)opponents {
	
}

// current player shot at player at tile
- (void)player:(id)aPlayer shotPlayer:(id)shotPlayer atTile:(CGPoint)tile {
	BSShot *shot = [[[BSShot alloc] init] autorelease];
	shot.sender = aPlayer;
	shot.receiver = shotPlayer;
	shot.hit = BSShotHitUnknown;
	shot.tile = tile;
	
	
}

// when the player did really pause the game
- (void)playerDidPauseGame:(id)aPlayer {
	
}

// when the player did resume again
- (void)playerDidResumeGame:(id)aPlayer {
	
}

// asks if a player can pause the game
- (BOOL)playerCanPauseGame:(id)aPlayer {
	
}

// tells that a player did quit
- (void)playerDidQuitGame:(id)aPlayer {
	
}

# pragma mark GKSessionDelegate

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state {
	
}

- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context {
	NSLog(data);
}

/*- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID {
	
}*/

- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error {
	
}

- (void)session:(GKSession *)session didFailWithError:(NSError *)error {
	
}

#pragma mark Network Stuff

- (void)sendShot:(BSShot *)aShot toPeer:(BSPlayerOpponent *)aPlayer {
	
}

- (void)sendNetworkPacket:(GKSession *)session packetID:(int)packetID data:(void *)data length:(int)length {
	static unsigned char packet[1024];
	const unsigned int headerSize = 2 * sizeof(int);
	
	if (length < 1024 - headerSize) {
		int *pData = (int *)&packet[0];
		pData[0] = gamePacketNumber++;
		pData[1] = packetID;
		
		memcpy(&packet[headerSize], data, length);
		NSData *packet = [NSData dataWithBytes:packet length:(length+headerSize)];
		
		NSError *err = [[[NSError alloc] init] autorelease];
		[session sendData:data toPeers:[NSArray arrayWithObject:[aPlayer peerID]] withDataMode:GKSendDataReliable error:&err];
	} else {
		
	}
}

- (void)dealloc {
	[session release];
	[peerID release];
	[super dealloc];
}

@end
