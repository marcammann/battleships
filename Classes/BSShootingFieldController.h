//
//  BSShootingFieldController.h
//  Baddleships
//
//  Created by Marc Ammann on 6/22/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSPlayFieldController.h"
#import "BSPlayerController.h"


@interface BSShootingFieldController : BSPlayFieldController {
	BSPlayerController *enemy;
}

@property (nonatomic, retain) BSPlayerController *enemy;

@end
