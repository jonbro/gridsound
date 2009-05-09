//
//  parentController.h
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 4/10/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "gridController.h"
#include "ofMain.h"
#include "ofxiPhoneKeyboard.h"

//#import "phraseController.h"

@interface parentController : NSObject {
	bool renderSmall;
	int currentGrid;
	float y_offset, x_offset, scale, target_y, target_x, target_scale; // lol, should move this shit into vectors
	float endTime;
	NSMutableArray *instrumentGroup;
	NSMutableString *currentState;
	NSMutableArray	*children;
	NSMutableArray	*filtering;
}

@property (nonatomic, retain) NSMutableArray *instrumentGroup;
@property (assign) NSMutableArray* children;

-(void)render;
-(void)update;
-(void)addChild:(NSObject *)_child;
-(float)tweenQuadraticCurrentTime:(float)t startValue:(float)b valueChange:(float)c endTime_:(float)d;
-(float)tweenLinearCurrentTime:(float)t startValue:(float)b valueChange:(float)c endTime_:(float)d;
-(void)touchDownX:(float)x y:(float)y touchId:(int)touchId;
-(void)touchMoved:(float)x y:(float)y touchId:(int)touchId;
-(void)touchUpX:(float)x y:(float)y touchId:(int)touchId;

@end
