/*
 *  gridController.h
 *  iPhone Graphics Example
 *
 *  Created by jonbroFERrealz on 4/24/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>
#include "ofMain.h"


class GridControllerC {
public:
	GridControllerC();
	~GridControllerC();	
	void draw();
};


@interface gridController : NSObject {
	int steps[8];
	GridControllerC *gridC;
}

-(id)init;
-(void)doAnythingPlease;

@end
