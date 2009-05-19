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

gridControllerHelper::gridControllerHelper()
{
	buttonsOff.loadImage("allBtnsOffW.png");
	buttonsOffTex = buttonsOff.getTextureReference();
	
	buttonsOn.loadImage("allBtnsOnW.png");
	buttonsOnTex = buttonsOn.getTextureReference();
}

//--------------------------------------------------------------
gridControllerHelper::~gridControllerHelper()
{
	
}
void gridControllerHelper::drawButton(int buttonCounter, float x, float y)
{
	if(buttonCounter == 0){
		curTex = buttonsOffTex;
	}else{
		curTex = buttonsOnTex;
	}
	glPushMatrix();
	glTranslatef(x,y,0.0f);			
	float tex_t = curTex.texData.tex_t/8.0*x;
	float tex_u = curTex.texData.tex_u/8.0*y;
	myShape.begin(GL_TRIANGLE_STRIP);
	myShape.setTexCoord(0, 0);
	myShape.addVertex(0, 0);
	
	myShape.setTexCoord(tex_t, 0);
	myShape.addVertex(320/8, 0);
	
	myShape.setTexCoord(0, tex_u);
	myShape.addVertex(0, 320/8);
	
	myShape.setTexCoord(tex_t, tex_u);
	myShape.addVertex(320/8, 320/8);
	
	myShape.enableColor(false);
	myShape.enableNormal(false);
	myShape.enableTexCoord(true);
	myShape.end();	
	glPopMatrix();
}

@implementation gridController

@synthesize playbackMode;

-(id) init:(RemoteIOPlayer *)_player loopSamples:(NSArray *)_loopSamples noteSamples:(NSArray *)_noteSamples
{
	self = [super init];
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
	self.playbackMode = 0;
	picker = new ofxiPhonePickerView(0, 520, 320, 240, [loopSamples retain]);
	pickerStyleSegmentedControl.selectedSegmentIndex = 0;
	gcHelper = new gridControllerHelper();
	return self;
}
-(void)showModePicker
{
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
		steps[i] = stepValue;
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
	ofSetColor(0xEB008B);
	for(int j = 0; j < 8; j++){
		for(int i = 0; i < 8; i++){
			ofSetColor(0xEB008B);
			if(steps[j] == i){
				gcHelper->drawButton(0, j*40+2, i*40+2+y_offset);
			}else{
				gcHelper->drawButton(1, j*40+2, i*40+2+y_offset);
			}
		}
	}
	[self drawBottomBar];
	[self drawVolumeBar];
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
		currentSample = picker->getRow();
	}
	picker->setPosition(0, 520+y_offset);	
	[self setModePickerPosition:0 y:480+y_offset];
}
-(int)getStep:(int)_step
{
	return steps[_step];
}
-(int)volumeLevel
{
	return volumeLevel;
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
	currentSample = _sample;
}
-(int)getSample
{
	if(pickerStyleSegmentedControl.selectedSegmentIndex == 1){
		return currentSample+[loopSamples count];
	}else{
		return currentSample;
	}
}
-(void)touchDownX:(float)x y:(float)y touchId:(int)touchId{
	if([currentState isEqual:@"display_grid"]){
		int touchedPos = (int)(y/320.0*8.0);
		if(touchedPos<8){
			steps[(int)(x/320.0*8.0)] = touchedPos;
		}else if(touchedPos==8){
			volumeLevel = (int)(x/320.0*255.0);
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
-(void)touchMoved:(float)x y:(float)y touchId:(int)touchId{
	steps[(int)(x/320.0*8.0)] = (int)(y/320.0*8.0);
}
-(void)touchUp:(float)x y:(float)y touchId:(int)touchId{
}

@end