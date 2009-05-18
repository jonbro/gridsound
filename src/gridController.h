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
#import "ofxMSAShape3D.h"

@interface gridController : NSObject {
	int steps[8];
	int currentSample, numLoops, playbackMode;
	float y_offset;
	int volumeLevel;
	NSArray *noteSamples, *loopSamples;
	NSMutableString *currentState;
	UISegmentedControl	*pickerStyleSegmentedControl;
	ofImage buttonsOn, buttonsOff;
	ofxMSAShape3D myShape;
	ofTexture buttonsOnTex, buttonsOffTex;
	ofxiPhonePickerView *picker;
	RemoteIOPlayer *player;
}

@property (assign) int playbackMode;

-(id) init:(RemoteIOPlayer *)_player loopSamples:(NSArray *)_loopSamples noteSamples:(NSArray *)_noteSamples;
-(void)showModePicker;
-(void)hideModePicker;
-(void)toggleMode:(id)sender;
-(void)setModePickerPosition:(int)x y:(int)_y;
-(void)render;
-(int)getSample;
-(void)setSample:(int)_sample;
-(void)update;
-(int)getStep:(int)_step;
-(void)setAll:(int)stepValue;
-(int)volumeLevel;
-(void)drawBottomBar;
-(void)drawVolumeBar;
-(void)touchDownX:(float)x y:(float)y touchId:(int)touchId;
-(void)touchMoved:(float)x y:(float)y touchId:(int)touchId;
-(void)touchUp:(float)x y:(float)y touchId:(int)touchId;

@end
