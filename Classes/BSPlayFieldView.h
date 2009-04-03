//
//  BSPlayFieldView.h
//  Battleships
//
//  Created by Marc Ammann on 3/28/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSPlayFieldBlock : UIView {
	NSInteger x;
	NSInteger y;
	BOOL occupied;
}

@property (assign) NSInteger x, y;
@property (assign) BOOL occupied;
@end

@interface BSPlayFieldView : UIView {
	UIView *playField;
	UIView *indexRow;
	UIView *indexColumn;
}

@property (readonly) UIView *playField;

- (id)initWithTilenumber:(NSInteger)number;

@end
