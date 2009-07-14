//
//  BSGameClient.h
//  Baddleships
//
//  Created by Marc Ammann on 7/13/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "BSShot.h"
#import "BSPlayerController.h"

typedef enum {
	NETWORK_SHOT,
	NETWORK_FIELD,
	NETWORK_HEARTBEAT,
} packetCode;


@interface BSGameClient : NSObject <GKSessionDelegate, BSPlayerControllerInteractionDelegate> {
	// The Session, the client is using
	GKSession *session;
	
	// Servers peer ID
	NSString *peerID;
	
	// The player
	id player;
	
	// The players opponents
	NSMutableArray *_opponents;
	
	// If the current client is active
	BOOL isActive;
	
	// The current game packet number
	int gamePacketNumber;
}

@property (nonatomic, retain) GKSession *session;
@property (nonatomic, retain) NSString *peerID;
@property (nonatomic, assign) id player;

@end
