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

-(id) init:(RemoteIOPlayer *)_player loopSamples:(NSArray *)_loopSamples noteSamples:(NSArray *)_noteSamples gcHelper:(gridControllerHelper *)_gcHelper
{
	self = [super init];
	gcHelper = _gcHelper;
	for(int i=0;i<8;i++){
		steps[i] = i;
	}
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
	volumeLevel = 80;
	touchingVolume = false;
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

//	for(int j = 0; j < 8; j++){
//		[[ripples objectAtIndex:j] renderX:j*40+20 Y:[[model.steps objectAtIndex:j]intValue]*40+y_offset+20];
//	}
	for(int i = 0; i < 8; i++){
		if(![[model.mutes objectAtIndex:i]boolValue]){
			gcHelper->drawButton(i, [[model.steps objectAtIndex:i]intValue], max(0, min(7, (int)([[ripples objectAtIndex:i]getScale]*7.0))));
		}
	}
	gcHelper->drawVolume((float)volumeLevel/255.0);
	gcHelper->drawForeground();

}
-(void)update
{
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
	if([[model.mutes objectAtIndex:currentStep]boolValue]){
		return 0;
	}else{
		return volumeLevel;
	}
}
-(void)setModel:(gridModel *)_model
{
	[model release];
	model = [_model retain];
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
		int sliderLeft = ((float)volumeLevel/255.0)*80;
		if(y>369&&y<410&&x>sliderLeft&&x<sliderLeft+89){
			volumeStart = x;
			touchingVolume = true;
			volumeFinger = touchId;
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
		volumeLevel += ((x-volumeStart)/89.0)*255.0;
		volumeStart = x;
		volumeLevel = min(255, max(0, volumeLevel));
	}else{
		[model.steps replaceObjectAtIndex:(int)(x/320.0*8.0) withObject:[NSNumber numberWithInt:(int)(y/320.0*8.0)]];
	}
}
-(void)touchUp:(float)x y:(float)y touchId:(int)touchId{
	if(touchingVolume && touchId == volumeFinger){
		touchingVolume = false;
	}
}

@end