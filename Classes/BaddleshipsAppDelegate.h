//
//  BaddleshipsAppDelegate.h
//  Baddleships
//
//  Created by Marc Ammann on 3/31/09.
//  Copyright Codesofa 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSStartViewController.h"




@interface BaddleshipsAppDelegate : NSObject <UIApplicationDelegate> {
	BSStartViewController *baseContainer;
	
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) BSStartViewController *baseContainer;


@end

