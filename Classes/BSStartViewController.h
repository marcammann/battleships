//
//  BSContainerViewController.h
//  Battleships
//
//  Created by Marc Ammann on 3/28/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BSSetupCPUViewController.h"
#import "BSSetupCPUSkillViewController.h"
#import "BSSetupNetworkPeerViewController.h"


@interface BSStartViewController : UIViewController {
	UIButton *vsCpuButton;
	UIButton *vsPlayerButton;
	UIButton *vsNetworkButton;
	UIButton *settingsButton;
}

@end
