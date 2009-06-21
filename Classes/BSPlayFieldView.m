//
//  BSPlayFieldView.m
//  Battleships
//
//  Created by Marc Ammann on 3/28/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import "BSPlayFieldView.h"
#import "Constants.h"


@implementation BSPlayFieldView

@synthesize playField;
@synthesize tileSize;
@synthesize controller;

- (id)initWithSize:(NSNumber *)size frame:(CGRect)aFrame {
    if (self = [super initWithFrame:aFrame]) {
		playField = [[UIImageView alloc] init];
		indexRow = [[UIView alloc] init];
		indexColumn = [[UIView alloc] init];
		[self setTileSize:30.0f];
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = touches.anyObject;
	
	NSLog(@"field touched");
	
	if (touch.tapCount == 1) {
		[controller fieldView:self tappedAt:[touch locationInView:[self superview]]];
	} 
	
}

- (void)setTileSize:(CGFloat)aTileSize {
	tileSize = aTileSize;
	
	// set the frame..
	CGFloat prop = tileSize / kTileSize;
	CGFloat constraints = kTotalFieldSize * prop;
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, constraints, constraints);
}

- (void)drawRect:(CGRect)rect {
	// We take the current tile Size and take the proportion to the big size to
	// calculate all other values
	CGFloat prop = tileSize / kTotalFieldSize;
	
	CGFloat indexBarSize = (kTotalFieldSize - kPlayFieldSize) * prop;
	CGFloat playFieldSize = kPlayFieldSize * prop;
	playField.frame = CGRectMake(indexBarSize, indexBarSize, playFieldSize, playFieldSize);
	
	indexRow.frame = CGRectMake(indexBarSize, 0.0f, playFieldSize, indexBarSize);
	indexColumn.frame = CGRectMake(0.0f, indexBarSize, indexBarSize, playFieldSize);
	
	// Get the basic proportions
	
	if (CGRectGetWidth(self.frame) == 128.0f) {
		playField.image = [UIImage imageNamed:@"playfieldBgSmallPlain.png"];
	} else {
		playField.image = [UIImage imageNamed:@"playfieldBgPlain.png"];
	}
	[self addSubview:playField];

	indexRow.backgroundColor = [UIColor greenColor];
	[self addSubview:indexRow];
	
	indexColumn.backgroundColor = [UIColor lightGrayColor];
	[self addSubview:indexColumn];
    
	// Drawing code
}

- (UIImage *)scaledBackgroundImage {
	CGImageRef image = [[UIImage imageNamed:@"playfieldBgSmallPlain.png"] CGImage];
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL, 120, 120, 8, 0, colorSpace, kCGImageAlphaPremultipliedFirst);
	CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, 120.0f, 120.0f), image);
	CGImageRef newImage = CGBitmapContextCreateImage(context);
	CGContextRelease(context);
	
	return [UIImage imageWithCGImage:newImage];
}

- (void)dealloc {
	[playField release];
	[indexRow release];
	[indexColumn release];
    [super dealloc];
}


@end
