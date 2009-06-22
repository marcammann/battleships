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

- (void)animateToViewSize:(BSViewSize)aSize position:(CGPoint)position duration:(CGFloat)duration {
	[UIView beginAnimations:@"playFieldAnimation" context:NULL];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	
	CGFloat tmpTileSize = (aSize == BSViewSizeSmall) ? kSmallTileSize : kTileSize;
	[self setTileSize:tmpTileSize];
	
	CGFloat prop = tmpTileSize / kTileSize;
	CGFloat constraints = kTotalFieldSize * prop;
	
	NSLog(@"%.2f", prop);
	
	self.frame = CGRectMake(position.x, position.y, constraints, constraints);
	[UIView commitAnimations];
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	[self setNeedsDisplay];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = touches.anyObject;
	
	NSLog(@"field touched");
	
	if (touch.tapCount == 1) {
		[controller fieldView:self tappedAt:[touch locationInView:[self superview]]];
	} 
}



- (void)setTileSize:(CGFloat)aTileSize {
	NSLog(@"play field: %.2f", aTileSize);
	tileSize = aTileSize;
	
	// set the frame..
	CGFloat prop = tileSize / kTileSize;	
	CGFloat constraints = kTotalFieldSize * prop;
	CGFloat indexBarSize = (kTotalFieldSize - kPlayFieldSize) * prop;
	CGFloat playFieldSize = kPlayFieldSize * prop;
	
	playField.frame = CGRectMake(indexBarSize, indexBarSize, playFieldSize, playFieldSize);
	indexRow.frame = CGRectMake(indexBarSize, 0.0f, playFieldSize, indexBarSize);
	indexColumn.frame = CGRectMake(0.0f, indexBarSize, indexBarSize, playFieldSize);
	
	if (CGRectGetWidth(self.frame) > 128.0f) {
		playField.image = [UIImage imageNamed:@"playfieldBgPlain.png"];
	}
}

- (void)drawRect:(CGRect)rect {
	// We take the current tile Size and take the proportion to the big size to
	// calculate all other values	
	
	// Get the basic proportions
	CGFloat prop = tileSize / kTileSize;	
	CGFloat constraints = kTotalFieldSize * prop;
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, constraints, constraints);
	
	if (CGRectGetWidth(self.frame) == 128.0f) {
		playField.image = [UIImage imageNamed:@"playfieldBgSmallPlain.png"];
	} else {
		playField.image = [UIImage imageNamed:@"playfieldBgPlain.png"];
	}
	
	[playField setClipsToBounds:YES];
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
