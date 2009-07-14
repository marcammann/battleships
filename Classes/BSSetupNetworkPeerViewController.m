//
//  BSSetupNetworkPeerViewController.m
//  Baddleships
//
//  Created by Marc Ammann on 6/28/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import "BSSetupNetworkPeerViewController.h"

@implementation BSSetupNetworkPeerViewController

@synthesize gameSession;

- (id)initAsServer:(BOOL)_asServer {
	if (self = [super init]) {
		isServer = _asServer;
		
		if (isServer) {
			gameDirector = [[BSGameDirector alloc] init];
		}
	}
	
	return self;
}

- (void)loadView {
	[super loadView];
	
	if (isServer) {
		gameSession = [[GKSession alloc] initWithSessionID:@"com.hadronicmonkee.battleships" displayName:@"Admiral Kirk" sessionMode:GKSessionModeServer];
	} else {
		gameSession = [[GKSession alloc] initWithSessionID:@"com.hadronicmonkee.battleships" displayName:@"Sergeant Zulu" sessionMode:GKSessionModeClient];
	}
	
	gameSession.delegate = self;
	[gameSession setDataReceiveHandler:self withContext:nil];
	gameSession.available = YES;
}

- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID {
	NSLog(@"Connection Requested!");
	gameClient = [[BSGameClientLocalServer alloc] initWithGameSession:session peerID:peerID];
	[gameClient session:session didReceiveConnectionRequestFromPeer:peerID];
}

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state {
	NSLog(@"Connection State Changed");
	if (isServer == NO) {
		gameClientClient = [[BSGameClientLocalClient alloc] initWithGameSession:session peerID:peerID];
		[session connectToPeer:peerID withTimeout:10.0f];
		[gameClientClient session:session peer:peerID didChangeState:state];
	}
}


- (void)dealloc {
    [super dealloc];
}


@end
