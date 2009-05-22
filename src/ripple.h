//
//  ripple.h
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 5/21/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "ofMain.h"

@interface ripple : NSObject {
	float endTime, startTime;
	float x, y, scale;
	NSMutableString *currentState;
}

@property (assign) float x;
@property (assign) float y;
@property (assign) float scale;
-(void)renderX:(float)_x Y:(float)_y;
-(void)update;
-(void)startPulse;
-(float)tweenLinearCurrentTime:(float)t startValue:(float)b valueChange:(float)c endTime_:(float)d;
@end