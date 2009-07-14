//
//  BSGameClientLocalClient.m
//  Baddleships
//
//  Created by Marc Ammann on 7/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BSGameClientLocalClient.h"


@implementation BSGameClientLocalClient

- (id)initWithGameSession:(GKSession *)session peerID:(NSString *)_peerID {
	if (self = [super init]) {
		peerID = peerID;
		gameSession = [session retain];
		gameSession.delegate = self;
		[gameSession setDataReceiveHandler:self withContext:nil];
	}
	
	return self;
}

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state {
	NSLog(@"Here I am");
	if (state == GKPeerStateConnected) {
		NSLog(@"Connected with Peer: %@, Name: %@", peerID, [session displayNameForPeer:peerID]);
	} 
	[session connectToPeer:peerID withTimeout:10.0f];
}

- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID {
	NSLog(@"Peer Tried to connect: %@, Name: %@", peerID, [session displayNameForPeer:peerID]);
	[session acceptConnectionFromPeer:peerID error:nil];
}

- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error {
	NSLog(@"Connection Failed");
}

- (void)session:(GKSession *)session didFailWithError:(NSError *)error {
	NSLog(@"Error in Connection");
}

- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context {
	NSLog(peer);
}

@end
