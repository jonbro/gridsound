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
#import "gridModel.h"
#import "parentModel.h"

@interface gridController : NSObject {
	int steps[8];
	int currentSample, numLoops, playbackMode, currentStep;
	int channel, gridNumber;
	float y_offset;
	int volumeLevel;
	bool touchingVolume, showSamplePicker;
	int volumeStart, volumeFinger;
	NSArray *loopSamples;
	NSMutableArray *ripples;
	gridModel *model;
	parentModel *pModel;
	NSMutableString *currentState;
	UISegmentedControl	*pickerStyleSegmentedControl;
	gridControllerHelper *gcHelper;
	ofxiPhonePickerView *picker;
	RemoteIOPlayer *player;
}

@property (assign) int playbackMode;

-(id) init:(RemoteIOPlayer *)_player loopSamples:(NSArray *)_loopSamples gcHelper:(gridControllerHelper *)_gcHelper channelNumber:(int)_channel gridNumber:(int)_gridNumber;
-(void)showModePicker;
-(void)hideModePicker;
-(void)toggleMode:(id)sender;
-(void)setModel:(gridModel *)_model;
-(void)setParentModel:(parentModel *)_parentModel;
-(void)setModePickerPosition:(int)x y:(int)_y;
-(void)render;
-(void)setupPickers;
-(int)getSample;
-(void)setSample:(int)_sample;
-(void)update;
-(int)getStep:(int)_step;
-(void)setAll:(int)stepValue;
-(int)volumeLevel;
-(void)hideBelt;
-(void)touchDownX:(float)x y:(float)y touchId:(int)touchId;
-(void)doubleTapX:(float)x y:(float)y touchId:(int)touchId;
-(void)touchMoved:(float)x y:(float)y touchId:(int)touchId;
-(void)touchUp:(float)x y:(float)y touchId:(int)touchId;

@end
