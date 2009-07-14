//
//  BSShootingFieldController.h
//  Baddleships
//
//  Created by Marc Ammann on 6/22/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSPlayFieldController.h"


@interface BSShootingFieldController : BSPlayFieldController {
	id enemy;
}

@property (nonatomic, retain) id enemy;

@end
