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

-(id) init:(RemoteIOPlayer *)_player loopSamples:(NSArray *)_loopSamples noteSamples:(NSArray *)_noteSamples gcHelper:(gridControllerHelper *)_gcHelper channelNumber:(int)_channel
{
	self = [super init];
	gcHelper = _gcHelper;
	for(int i=0;i<8;i++){
		steps[i] = i;
	}
	channel = _channel;
	y_offset = 0;
	player = _player;
	loopSamples = [_loopSamples retain];
	noteSamples = [_noteSamples retain];
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
-(void)showModePicker
{
	[self setupPickers];
	[iPhoneGlobals.window addSubview:pickerStyleSegmentedControl];
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
			picker->setNewArray([noteSamples retain]);
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
	gcHelper->showBelt(loopSamples);
}
-(void)update
{
	gcHelper->setCurrentLoop([model.currentSample intValue]);
	if([currentState isEqual:@"to_settings"]){
		if(y_offset>-260){
			y_offset = (y_offset-260)/2;
		}else{
			[currentState setString:@"at_settings"];
		}
	}else if([currentState isEqual:@"from_settings"]){
		if(y_offset<-1){
			y_offset = (y_offset-0)/2;
		}else{
			y_offset = 0;
			picker->setVisible(false);
			[self hideModePicker];
			[currentState setString:@"display_grid"];
		}
	}else if([currentState isEqual:@"at_settings"]){
		model.currentSample = [NSNumber numberWithInt:picker->getRow()];
	}
	for(int i=0;i<8;i++){
		[[ripples objectAtIndex:i] update];
	}
	if(fmod((double)player.tick, (double)8)!=currentStep){
		currentStep = fmod((double)player.tick, (double)8);
		if(![[model.mutes objectAtIndex:currentStep]boolValue]){
			[[ripples objectAtIndex:currentStep] startPulse];
		}
	}	
	picker->setPosition(0, 520+y_offset);	
	[self setModePickerPosition:0 y:480+y_offset];
}
-(int)getStep:(int)_step
{
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
-(void)drawVolumeBar
{
	int volumeWidth = 320*((float)volumeLevel/255.0);
	ofFill();
	ofSetColor(0xCCCCCC);
	ofRect(0, 322+y_offset, 320, 40); 
	ofSetColor(0xEB008B);
	ofRect(0, 322+y_offset, volumeWidth, 40);	
}
-(void)drawBottomBar
{
	//draw minus button
	ofFill();
	ofSetColor(0xCCCCCC);
	ofRect(275, 435+y_offset, 45, 45); 
	ofSetColor(0xFFFFFF);
	ofRect(285, 453+y_offset, 25, 9);
	// draw settings helper down.
	ofSetColor(0xCCCCCC);
	ofRect(0, 435+y_offset, 45, 45); 
	ofSetColor(0xFFFFFF);
	if([currentState isEqual:@"display_grid"]){
		ofTriangle(10, 450+y_offset, 35, 450+y_offset, 22.5, 470+y_offset);
	}else{
		ofTriangle(10, 470+y_offset, 35, 470+y_offset, 22.5, 450+y_offset);
	}
}
-(void)setSample:(int)_sample
{
	[model setCurrentSample:[NSNumber numberWithInt:_sample]];
	picker->setRow(_sample);
}
-(void)setupPickers
{
	picker->setRow([model.currentSample intValue]);
}
-(int)getSample
{
	if(pickerStyleSegmentedControl.selectedSegmentIndex == 1){
		return [model.currentSample intValue]+[loopSamples count];
	}else{
		return [model.currentSample intValue];
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
				model.currentSample = [NSNumber numberWithInt:(int)(y)/40];
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
	}
	if(x<45 && y > 435+y_offset){
		if([currentState isEqual:@"display_grid"]){
			[currentState setString:@"to_settings"];
			picker->setVisible(true);
			[self showModePicker];
		}else if([currentState isEqual:@"at_settings"]){
			[currentState setString:@"from_settings"];
		}
	}
}
-(void)doubleTapX:(float)x y:(float)y touchId:(int)touchId
{
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