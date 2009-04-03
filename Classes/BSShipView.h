//
//  BSShipView.h
//  Battleships
//
//  Created by Marc Ammann on 3/28/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSShipView : UIView {
	NSInteger size;
	CGPoint dragPosition;
	CGPoint fieldPosition;
}

@property (assign) NSInteger size;
@property (assign) CGPoint dragPosition, fieldPosition;


- (id)initWithSize:(NSInteger)size;


@end
