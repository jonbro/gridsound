/*
 *  gridController.mm
 *  iPhone Graphics Example
 *
 *  Created by jonbroFERrealz on 4/24/09.
 *  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
 *
 */

#import "gridController.h"

@implementation gridController

-(id) init:(RemoteIOPlayer *)_player
{
	self = [super init];
	for(int i=0;i<8;i++){
		steps[i] = i;
	}
	player = _player;
	return self;
}

-(void) render
{
	ofSetColor(0xEB008B);
	for(int i = 0; i < 8; i++){
		for(int j = 0; j < 8; j++){
			ofSetColor(0xEB008B);
			if(steps[j] == i){
				ofFill();
			}else{
				if(fmod(player.tick, 8)!=j){
					ofSetColor(0, 0, 0);
				}
				ofNoFill();
			}
			ofRect(i*40+2, j*40+2, 35, 35);    
		}
	}
	[self drawBottomBar];
}
-(int)getStep:(int)_step
{
	return steps[_step];
}
-(void)drawBottomBar
{
	//draw minus button
	ofFill();
	ofSetColor(0xCCCCCC);
	ofRect(275, 435, 45, 45); 
	ofSetColor(0xFFFFFF);
	ofRect(285, 453, 25, 9); 
}
-(void)touchDownX:(float)x y:(float)y touchId:(int)touchId{
	steps[(int)(y/320.0*8.0)] = (int)(x/320.0*8.0);
	if(x>285 && y>453){
		
	}
}
-(void)touchMoved:(float)x y:(float)y touchId:(int)touchId{
	steps[(int)(y/320.0*8.0)] = (int)(x/320.0*8.0);
}
-(void)touchUp:(float)x y:(float)y touchId:(int)touchId{
}

@end