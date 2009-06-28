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

- (id)init {
	if (self = [super init]) {
		
	}
	
	return self;
}

- (void)loadView {
	[super loadView];
	
	GKPeerPickerController *picker = [[GKPeerPickerController alloc] init];
	picker.delegate = self;
	picker.connectionTypesMask = GKPeerPickerConnectionTypeNearby | GKPeerPickerConnectionTypeOnline;
	
	[picker show];
}

- (void)peerPickerController:(GKPeerPickerController *)picker didSelectConnectionType:(GKPeerPickerConnectionType)type {
    if (type == GKPeerPickerConnectionTypeOnline) {
        picker.delegate = nil;
        [picker dismiss];
        [picker autorelease];
		// Implement your own internet user interface here.
    }
}

- (GKSession *)peerPickerController:(GKPeerPickerController *)picker sessionForConnectionType:(GKPeerPickerConnectionType)type {
    GKSession* session = [[GKSession alloc] initWithSessionID:@"com.hadronicmonkee.battleships" displayName:@"Admiral Kirk" sessionMode:GKSessionModePeer];
    [session autorelease];
    return session;
}

- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession: (GKSession *) session {
	// Use a retaining property to take ownership of the session.
    self.gameSession = session;
	// Assumes our object will also become the session's delegate.
    session.delegate = self;
    [session setDataReceiveHandler: self withContext:nil];
	// Remove the picker.
    picker.delegate = nil;
    [picker dismiss];
    [picker autorelease];
	// Start your game.
}

- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker {
    picker.delegate = nil;
    // The controller dismisses the dialog automatically.
    [picker autorelease];
}

- (void)dealloc {
    [super dealloc];
}


@end
