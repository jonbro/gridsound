/*
 *  gridController.mm
 *  iPhone Graphics Example
 *
 *  Created by jonbroFERrealz on 4/24/09.
 *  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
 *
 */

#import "gridController.h"
#import "iPhoneGlobals.h"

@implementation gridController

@synthesize playbackMode;

-(id) init:(RemoteIOPlayer *)_player loopSamples:(NSArray *)_loopSamples gcHelper:(gridControllerHelper *)_gcHelper channelNumber:(int)_channel gridNumber:(int)_gridNumber
{
	self = [super init];
	gcHelper = _gcHelper;
	for(int i=0;i<8;i++){
		steps[i] = i;
	}
	gridNumber = _gridNumber;
	channel = _channel;
	y_offset = 0;
	player = _player;
	loopSamples = [[NSMutableArray alloc]initWithCapacity:1];
#ifdef HRVERSION
	for(int i=channel*6;i<min((int)[_loopSamples count], (channel+1)*6);i++){
		[loopSamples addObject:[_loopSamples objectAtIndex:i]];
	}
#endif
#ifndef HRVERSION
	loopSamples = [_loopSamples retain];
#endif
	pickerStyleSegmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Cutter", @"Note", nil]];
	[pickerStyleSegmentedControl addTarget:self action:@selector(toggleMode:) forControlEvents:UIControlEventValueChanged];
	pickerStyleSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	ripples = [[NSMutableArray alloc]initWithCapacity:8];
	for(int i=0;i<8;i++){
		[ripples addObject:[[ripple alloc]init]];
	}
	pickerStyleSegmentedControl.tintColor = [UIColor darkGrayColor];
    pickerStyleSegmentedControl.backgroundColor = [UIColor clearColor];
	[pickerStyleSegmentedControl sizeToFit];
	pickerStyleSegmentedControl.hidden = NO;
	numLoops = [loopSamples count];
	CGRect segmentedControlFrame = CGRectMake(480,
											  20,
											  320,
											  40);
    pickerStyleSegmentedControl.frame = segmentedControlFrame;
	currentState = [[NSMutableString alloc] initWithString:@"display_grid"];
	touchingVolume = false;
	showSamplePicker = false;
	currentStep = 0;
	self.playbackMode = 0;
	picker = new ofxiPhonePickerView(0, 520, 320, 240, [loopSamples retain]);
	pickerStyleSegmentedControl.selectedSegmentIndex = 0;
	return self;
}
- (void)toggleMode:(id)sender
{
	UISegmentedControl *segControl = sender;
	switch (segControl.selectedSegmentIndex)
	{
		case 0:	// UIPickerView
		{
			self.playbackMode = 0;
			picker->setNewArray([loopSamples retain]);
			break;
		}
		case 1: // UIDatePicker
		{	
			self.playbackMode = 1;
//			picker->setNewArray([noteSamples retain]);
			break;
		}			
	}
}
-(void)setAll:(int)stepValue
{
	for(int i=0;i<8;i++){
		[model.steps replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:stepValue]];
	}
}
- (void) hideModePicker
{
	[pickerStyleSegmentedControl removeFromSuperview];
}
-(void)setModePickerPosition:(int)x y:(int)y
{
	[pickerStyleSegmentedControl setFrame: CGRectMake(x,y,320,40)];
}
-(void) render
{
	gcHelper->drawBackground();
	for(int i=0;i<8;i++){
		[[ripples objectAtIndex:i] update];
	}	
	for(int i = 0; i < 8; i++){
		if(![[model.mutes objectAtIndex:i]boolValue]){
			gcHelper->drawButton(i, [[model.steps objectAtIndex:i]intValue], max(0, min(7, (int)([[ripples objectAtIndex:i]getScale]*7.0))));
		}
	}
	volumeLevel = [[pModel.volumes objectAtIndex:channel] intValue];
	gcHelper->drawVolume((float)volumeLevel/255.0);
	gcHelper->drawForeground(loopSamples);
	for(int i=0;i<3;i++){
		if([[pModel.mutes objectAtIndex:i]boolValue]){
			gcHelper->drawMute(i);
		}
	}
	gcHelper->drawDirection([[pModel.directions objectAtIndex:channel] boolValue]);
	gcHelper->drawLocation(gridNumber);
	gcHelper->showBelt(loopSamples);
}
-(void)update
{
	gcHelper->setCurrentLoop([[pModel.currentSamples objectAtIndex:channel] intValue]);
}
-(int)getStep:(int)_step
{
	currentStep = fmod((double)player.tick, (double)8);
	if(![[model.mutes objectAtIndex:currentStep]boolValue]){
		[[ripples objectAtIndex:currentStep] startPulse];
	}	
	return [[model.steps objectAtIndex:_step]intValue];
}
-(int)volumeLevel
{
	if([[model.mutes objectAtIndex:currentStep]boolValue] || [[pModel.mutes objectAtIndex:channel]boolValue]){
		return 0;
	}else{
		return [[pModel.volumes objectAtIndex:channel] intValue];
	}
}
-(void)setModel:(gridModel *)_model
{
	[model release];
	model = [_model retain];
}
-(void)setParentModel:(parentModel *)_parentModel
{
	[pModel release];
	pModel = [_parentModel retain];
}
-(void)setSample:(int)_sample
{
	[pModel.currentSamples replaceObjectAtIndex:channel withObject:[NSNumber numberWithInt:_sample]];
	picker->setRow(_sample);
}
-(bool)getDirection
{
	return [[pModel.directions objectAtIndex:channel]boolValue];
}
-(int)getSample
{
#ifdef HRVERSION
	return [[pModel.currentSamples objectAtIndex:channel] intValue]+channel*6;
#endif
#ifndef HRVERSION
	return [[pModel.currentSamples objectAtIndex:channel] intValue];
#endif
}
-(void)hideBelt
{
	if(showSamplePicker){
		gcHelper->rollInBelt();
		showSamplePicker = false;		
	}
}
-(void)touchDownX:(float)x y:(float)y touchId:(int)touchId{
	if([currentState isEqual:@"display_grid"]){
		volumeLevel = [[pModel.volumes objectAtIndex:channel] intValue];
		int sliderLeft = ((float)volumeLevel/255.0)*80;
		if(y>369&&y<410&&x>sliderLeft&&x<sliderLeft+89){
			volumeStart = x;
			touchingVolume = true;
			volumeFinger = touchId;
		}
	}
	if(showSamplePicker){
		if(x>46 && x<138){
			if((y)/40<[loopSamples count]){
				[pModel.currentSamples replaceObjectAtIndex:channel withObject:[NSNumber numberWithInt:(int)(y)/40]];
			}
		}else{
			gcHelper->rollInBelt();
			showSamplePicker = false;
		}
	}else if(x>235&&y>315&&y<380){
		if(!showSamplePicker){
			gcHelper->rollOutBelt();
			showSamplePicker = true;
		}
	}else if(y>418){
		if(x>16&&x<70){
			[pModel.mutes replaceObjectAtIndex:0 withObject:[NSNumber numberWithBool:![[pModel.mutes objectAtIndex:0]boolValue]]];
		}
		if(x>86&&x<139){
			[pModel.mutes replaceObjectAtIndex:1 withObject:[NSNumber numberWithBool:![[pModel.mutes objectAtIndex:1]boolValue]]];
		}
		if(x>152&&x<206){
			[pModel.mutes replaceObjectAtIndex:2 withObject:[NSNumber numberWithBool:![[pModel.mutes objectAtIndex:2]boolValue]]];
		}		
	}else if(y<320){
		[model.steps replaceObjectAtIndex:(int)(x/320.0*8.0) withObject:[NSNumber numberWithInt:(int)(y/320.0*8.0)]];
	}else if(x>135&&y>318&&x<203&&y<365){
		[pModel.directions replaceObjectAtIndex:channel withObject:[NSNumber numberWithBool:![[pModel.directions objectAtIndex:channel]boolValue]]];
	}
}
-(void)doubleTapX:(float)x y:(float)y touchId:(int)touchId
{
	if(gridNumber<3){
		// set mute state here.
		int clickedStep = (int)(x/320.0*8.0);
		int lastMuteState = [[model.mutes objectAtIndex:clickedStep]intValue];	
		if(lastMuteState == 1){
			lastMuteState = 0;
		}else{
			lastMuteState = 1;
		}
		[model.mutes replaceObjectAtIndex:clickedStep withObject:[NSNumber numberWithInt:lastMuteState]];
	}
}
-(void)touchMoved:(float)x y:(float)y touchId:(int)touchId{
	if(touchingVolume && touchId == volumeFinger){
		volumeLevel = [[pModel.volumes objectAtIndex:channel] intValue];
		volumeLevel += ((x-volumeStart)/89.0)*255.0;
		volumeStart = x;
		volumeLevel = min(255, max(0, volumeLevel));
		[pModel.volumes replaceObjectAtIndex:channel withObject:[NSNumber numberWithInt:volumeLevel]];
	}else if(y<320){
		[model.steps replaceObjectAtIndex:(int)(x/320.0*8.0) withObject:[NSNumber numberWithInt:(int)(y/320.0*8.0)]];
	}
}
-(void)touchUp:(float)x y:(float)y touchId:(int)touchId{
	if(touchingVolume && touchId == volumeFinger){
		touchingVolume = false;
	}
}

@end