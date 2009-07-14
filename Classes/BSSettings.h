//
//  BSSettings.h
//  Baddleships
//
//  Created by Marc Ammann on 6/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"


@interface BSSettings : SQLitePersistentObject {
	// The players nickname
	NSString *playerName;
	
	// The ship counts
	NSMutableArray *shipCounts;
}

@property (nonatomic, retain) NSMutableArray *shipCounts;
@property (nonatomic, retain) NSString *playerName;

@end
