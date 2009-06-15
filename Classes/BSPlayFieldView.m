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

- (id)initWithSize:(NSNumber *)size frame:(CGRect)aFrame {
    if (self = [super initWithFrame:aFrame]) {
		playField = [[UIImageView alloc] init];
		indexRow = [[UIView alloc] init];
		indexColumn = [[UIView alloc] init];
		
		CGFloat prop = self.frame.size.width / kTotalFieldSize;
		tileSize = kTileSize * prop;
		
		CGFloat indexBarSize = (kTotalFieldSize - kPlayFieldSize) * prop;
		CGFloat playFieldSize = kPlayFieldSize * prop;
		playField.frame = CGRectMake(indexBarSize, indexBarSize, playFieldSize, playFieldSize);
		
		indexRow.frame = CGRectMake(indexBarSize, 0.0f, playFieldSize, indexBarSize);
		indexColumn.frame = CGRectMake(0.0f, indexBarSize, indexBarSize, playFieldSize);
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
	// Get the basic proportions
	CGFloat prop = self.frame.size.width / kTotalFieldSize;
	
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
