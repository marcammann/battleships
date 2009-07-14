//
//  BaddleshipsAppDelegate.h
//  Baddleships
//
//  Created by Marc Ammann on 3/31/09.
//  Copyright Codesofa 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSStartViewController.h"
#import "BSSettings.h"



@interface BaddleshipsAppDelegate : NSObject <UIApplicationDelegate> {
	BSStartViewController *baseContainer;
	
	BSSettings *settings;
	
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) BSStartViewController *baseContainer;
@property (nonatomic, retain) BSSettings *settings;

@end

