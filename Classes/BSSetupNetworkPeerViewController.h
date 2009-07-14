//
//  BSSetupNetworkPeerViewController.h
//  Baddleships
//
//  Created by Marc Ammann on 6/28/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface BSSetupNetworkPeerViewController : UIViewController <GKPeerPickerControllerDelegate, GKSessionDelegate> {

	GKSession *gameSession;
}

@property (nonatomic, retain) GKSession *gameSession;

@end
