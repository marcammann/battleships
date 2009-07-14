//
//  BSPlayerOpponent.h
//  Baddleships
//
//  Created by Marc Ammann on 7/13/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSPlayFieldController.h"

typedef struct {
	int playerID;
	char displayName[128];
} playerInfo;

@interface BSPlayerOpponent : NSObject {
	// The players ID
	NSInteger *playerID;

	// Display Name
	NSString *displayName;
	
	// The shooting field
	BSPlayFieldController *shootingField;
}

@property (nonatomic, retain) NSString *peerID;
@property (nonatomic, retain) NSString *displayName;
@property (nonatomic, retain) BSPlayFieldController *shootingField;

@end
