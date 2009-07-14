/*
 *  Constants.h
 *  Baddleships
 *
 *  Created by Marc Ammann on 4/1/09.
 *  Copyright 2009 Codesofa. All rights reserved.
 *
 */

#ifndef _CONSTANTS_GUARD
#define _CONSTANTS_GUARD

#define kTileSize 30.0f
#define kSmallTileSize 12.0f
#define kPlayFieldSize 300.0f
#define kTotalFieldSize 320.0f
#define kPlayFieldFrame (kTotalFieldSize - kPlayFieldSize)

#define kTapDelay 0.2

#define kPlayFieldNumberOfTiles 10

typedef enum {
	BSViewSizeSmall,
	BSViewSizeLarge,
} BSViewSize;

#define CGLog(v) NSLog(@"%.2f / %.2f", v.x, v.y)

#define _DEBUG

#endif
