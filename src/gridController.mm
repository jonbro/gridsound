/*
 *  gridController.mm
 *  iPhone Graphics Example
 *
 *  Created by jonbroFERrealz on 4/24/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#import "gridController.h"

GridControllerC::GridControllerC()
{
}

//--------------------------------------------------------------
GridControllerC::~GridControllerC()
{
}


//--------------------------------------------------------------
void GridControllerC::draw()
{
	printf("anything");
}


@implementation gridController
-(id)init;
{
	if (self = [super init]) {
        gridC = new GridControllerC();
    }
	return self;
}

- (void)doAnythingPlease
{
	NSLog(@"HERE");
	gridC->draw();
}

@end