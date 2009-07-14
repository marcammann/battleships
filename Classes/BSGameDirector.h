//
//  BSGameDirector.h
//  Baddleships
//
//  Created by Marc Ammann on 7/12/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BSPlayerController.h"

@interface BSGameDirector : NSObject {
	NSMutableArray *players;
}

- (NSArray *)opponentsForPlayer:(BSPlayerController *)player;
- (NSArray *)shots;

@end