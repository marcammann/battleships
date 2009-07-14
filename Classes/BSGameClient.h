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

typedef struct {
	
	
} 

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
	
	
	int gamePacketNumber;
}

@property (nonatomic, retain) GKSession *session;
@property (nonatomic, retain) NSString *peerID;
@property (nonatomic, assign) id player;

@end
