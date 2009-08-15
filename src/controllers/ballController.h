//
//  ballController.h
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 5/11/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "vmath.h"
#include "ofMain.h"
#include "ofxAccelerometer.h"

@interface ballController : NSObject {
	int height, width;
	Vector2f ballPos, accelPos, velPos;
}

-(void)update;
-(void)render;
-(void)reset;
-(float)getX;
-(float)getY;
-(float)getUnscaledX;
-(float)getUnscaledY;
@end