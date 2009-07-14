//
//  BSSetupNetworkPeerViewController.h
//  Baddleships
//
//  Created by Marc Ammann on 6/28/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

#import "BSGameDirector.h"
#import "BSGameClientLocalServer.h"
#import "BSGameClientLocalClient.h"


@interface BSSetupNetworkPeerViewController : UIViewController <GKPeerPickerControllerDelegate, GKSessionDelegate> {
	BSGameDirector *gameDirector;

	BSGameClientLocalServer *gameClient;
	BSGameClientLocalClient *gameClientClient;
	
	GKSession *gameSession;
	
	BOOL isServer;
}

@property (nonatomic, retain) GKSession *gameSession;

@end
