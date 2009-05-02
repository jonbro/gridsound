/*
 *  gridController.h
 *  iPhone Graphics Example
 *
 *  Created by jonbroFERrealz on 4/24/09.
 *  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
 *
 */
#include "ofMain.h"
#import <Foundation/Foundation.h>
#import "RemoteIOPlayer.h"
#import "parentController.h"
#include "ofxiPhonePickerView.h"

@interface gridController : NSObject {
	int steps[8];
	int currentSample, numLoops, playbackMode;
	float y_offset;
	NSArray *noteSamples, *loopSamples;
	NSMutableString *currentState;
	UISegmentedControl	*pickerStyleSegmentedControl;
	ofxiPhonePickerView *picker;
	RemoteIOPlayer *player;
}

@property (assign) int playbackMode;

-(id) init:(RemoteIOPlayer *)_player loopSamples:(NSArray *)_loopSamples noteSamples:(NSArray *)_noteSamples;
-(void)showModePicker;
-(void) hideModePicker;
-(void)toggleMode:(id)sender;
-(void)setModePickerPosition:(int)x y:(int)_y;
-(void)render;
-(int)getSample;
-(void)update;
-(int)getStep:(int)_step;
-(void)drawBottomBar;
-(void)touchDownX:(float)x y:(float)y touchId:(int)touchId;
-(void)touchMoved:(float)x y:(float)y touchId:(int)touchId;
-(void)touchUp:(float)x y:(float)y touchId:(int)touchId;

@end
