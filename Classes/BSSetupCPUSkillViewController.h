//
//  BSSetupCPUSkillViewController.h
//  Baddleships
//
//  Created by Marc Ammann on 6/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BSSetupCPUSkillViewController : UIViewController {
	UIButton *beginnerButton;
	UIButton *advancedButton;
	
	UIImageView *backgroundView;
}

- (void)skillSelected:(id)sender;

@end
