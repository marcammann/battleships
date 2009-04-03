//
//  BSPlayFieldController.h
//  Baddleships
//
//  Created by Marc Ammann on 4/1/09.
//  Copyright 2009 Codesofa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSPlayFieldView.h"
#import "BSShipView.h"
#import "Constants.h"

@interface BSPlayFieldController : UIViewController {
	NSInteger tilesCount;
	NSMutableArray *occupiedFields;
	NSMutableArray *ships;
	
	BSPlayFieldView *view;
}

- (id)initWithTilenumber:(NSInteger)tiles;
- (void)placeShipInField:(BSShipView *)ship;
- (void)randomPlaceShipInField:(BSShipView *)ship;

- (CGPoint)blockPointForPoint:(CGPoint)point;

@property  (nonatomic, retain) BSPlayFieldView *view;

@end
