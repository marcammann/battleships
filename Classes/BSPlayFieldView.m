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
		playField = [[UIView alloc] init];
		indexRow = [[UIView alloc] init];
		indexColumn = [[UIView alloc] init];
		
		CGFloat prop = self.frame.size.width / kTotalFieldSize;
		tileSize = kTileSize * prop;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
	// Get the basic proportions
	CGFloat prop = self.frame.size.width / kTotalFieldSize;
	
	CGFloat indexBarSize = (kTotalFieldSize - kPlayFieldSize) * prop;
	CGFloat playFieldSize = kPlayFieldSize * prop;
	
	playField.frame = CGRectMake(indexBarSize, indexBarSize, playFieldSize, playFieldSize);
	
	UIImage *bgImage = [[UIImage imageNamed:@"tile_bg_paper.png"] stretchableImageWithLeftCapWidth:2 topCapHeight:2];
	playField.backgroundColor = [UIColor colorWithPatternImage:bgImage];
	[self addSubview:playField];

	indexRow.frame = CGRectMake(indexBarSize, 0.0f, playFieldSize, indexBarSize);
	indexRow.backgroundColor = [UIColor greenColor];
	[self addSubview:indexRow];
	
	indexColumn.frame = CGRectMake(0.0f, indexBarSize, indexBarSize, playFieldSize);
	indexColumn.backgroundColor = [UIColor lightGrayColor];
	[self addSubview:indexColumn];
    
	// Drawing code
}

- (void)dealloc {
	[playField release];
	[indexRow release];
	[indexColumn release];
    [super dealloc];
}


@end
