//
//  BSPlayFieldView.m
//  Battleships
//
//  Created by Marc Ammann on 3/28/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import "BSPlayFieldView.h"
#import "Constants.h"


@implementation BSPlayFieldBlock
@synthesize x, y, occupied;
@end

@implementation BSPlayFieldView

@synthesize playField;

- (id)initWithTilenumber:(NSInteger)number {
	CGRect frame = CGRectMake(0.0f, 0.0f, kTotalFieldSize, kTotalFieldSize);
    if (self = [super initWithFrame:frame]) {
		playField = [[UIView alloc] init];
		indexRow = [[UIView alloc] init];
		indexColumn = [[UIView alloc] init];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
	playField.frame = CGRectMake(kTotalFieldSize - kPlayFieldSize, kTotalFieldSize - kPlayFieldSize, kPlayFieldSize, kPlayFieldSize);
	playField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tile_bg_paper.png"]];
	[self addSubview:playField];

	indexRow.frame = CGRectMake(kTotalFieldSize - kPlayFieldSize, 0.0f, kPlayFieldSize, kTotalFieldSize - kPlayFieldSize);
	indexRow.backgroundColor = [UIColor greenColor];
	[self addSubview:indexRow];
	
	indexColumn.frame = CGRectMake(0.0f, kTotalFieldSize - kPlayFieldSize, kTotalFieldSize - kPlayFieldSize, kPlayFieldSize);
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
