//
//  BSPlayFieldView.h
//  Battleships
//
//  Created by Marc Ammann on 3/28/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@protocol BSPlayFieldViewDelegate
- (void)fieldView:(id)field tappedAt:(CGPoint)aPoint;
@end


@interface BSPlayFieldView : UIView {
	UIImageView *playField;
	UIView *indexRow;
	UIView *indexColumn;
	
	id<BSPlayFieldViewDelegate> controller;
	
	NSNumber *size;
	
	CGFloat tileSize;
}

@property (readonly) UIImageView *playField;
@property (nonatomic, readwrite) CGFloat tileSize;
@property (nonatomic, assign) id controller;

- (id)initWithSize:(NSNumber *)size;
- (void)animateToViewSize:(BSViewSize)aSize position:(CGPoint)position duration:(CGFloat)duration;

@end
