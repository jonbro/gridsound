/*
 *  gridController.h
 *  iPhone Graphics Example
 *
 *  Created by jonbroFERrealz on 4/24/09.
 *  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
 *
 */
#include "ofMain.h"
#import "ripple.h"
#import <Foundation/Foundation.h>
#import "RemoteIOPlayer.h"
#import "parentController.h"
#include "ofxiPhonePickerView.h"
#import "gridControllerHelper.h"
#import "gridModel.h";

@interface gridController : NSObject {
	int steps[8];
	int currentSample, numLoops, playbackMode, currentStep;
	float y_offset;
	int volumeLevel;
	NSArray *noteSamples, *loopSamples;
	NSMutableArray *ripples;
	gridModel *model;
	NSMutableString *currentState;
	UISegmentedControl	*pickerStyleSegmentedControl;
	gridControllerHelper *gcHelper;
	ofxiPhonePickerView *picker;
	RemoteIOPlayer *player;
}

@property (assign) int playbackMode;

-(id) init:(RemoteIOPlayer *)_player loopSamples:(NSArray *)_loopSamples noteSamples:(NSArray *)_noteSamples gcHelper:(gridControllerHelper *)_gcHelper;
-(void)showModePicker;
-(void)hideModePicker;
-(void)toggleMode:(id)sender;
-(void)setModel:(gridModel *)_model;
-(void)setModePickerPosition:(int)x y:(int)_y;
-(void)render;
-(void)setupPickers;
-(int)getSample;
-(void)setSample:(int)_sample;
-(void)update;
-(int)getStep:(int)_step;
-(void)setAll:(int)stepValue;
-(int)volumeLevel;
-(void)drawBottomBar;
-(void)drawVolumeBar;
-(void)touchDownX:(float)x y:(float)y touchId:(int)touchId;
-(void)doubleTapX:(float)x y:(float)y touchId:(int)touchId;
-(void)touchMoved:(float)x y:(float)y touchId:(int)touchId;
-(void)touchUp:(float)x y:(float)y touchId:(int)touchId;

@end
