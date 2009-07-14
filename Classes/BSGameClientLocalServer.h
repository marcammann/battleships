//
//  BSGameClientLocalServer.h
//  Baddleships
//
//  Created by Marc Ammann on 7/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface BSGameClientLocalServer : NSObject <GKSessionDelegate> {
	NSString *peerID;
	GKSession *gameSession;
}

- (id)initWithGameSession:(GKSession *)session peerID:(NSString *)_peerID;

@end
