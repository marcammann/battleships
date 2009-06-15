//
//  BSPlayFieldView.h
//  Battleships
//
//  Created by Marc Ammann on 3/28/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSPlayFieldView : UIView {
	UIView *playField;
	UIView *indexRow;
	UIView *indexColumn;
	
	id controller;
	
	NSNumber *size;
	
	CGFloat tileSize;
}

@property (readonly) UIView *playField;
@property (readonly) CGFloat tileSize;

- (id)initWithSize:(NSNumber *)size frame:(CGRect)frame;

@end
