//
//  BSPlayerOpponent.h
//  Baddleships
//
//  Created by Marc Ammann on 7/13/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSPlayFieldController.h"

@interface BSPlayerOpponent : NSObject {
	// The players ID
	NSString *peerID;

	// Display Name
	NSString *displayName;
	
	// The shooting field
	BSPlayFieldController *shootingField;
}

@property (nonatomic, retain) NSString *peerID;
@property (nonatomic, retain) NSString *displayName;
@property (nonatomic, retain) BSPlayFieldController *shootingField;

@end
