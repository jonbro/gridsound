/*
 *  gridController.mm
 *  iPhone Graphics Example
 *
 *  Created by jonbroFERrealz on 4/24/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#import "gridController.h"

@implementation gridController

-(id) init:(RemoteIOPlayer *)_player
{
	self = [super init];
	player = _player;
	return self;
}

-(void) draw
{
	ofSetColor(0xEB008B);
	for(int i = 0; i < 8; i++){
		for(int j = 0; j < 8; j++){
			ofSetColor(0xEB008B);
			if([player getStep:j] == i){
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
}

-(void)touchDownX:(float)x y:(float)y touchId:(int)touchId{
	[player setStep:(int)(y/320.0*8.0) stepValue:(int)(x/320.0*8.0)];
}
-(void)touchMoved:(float)x y:(float)y touchId:(int)touchId{
	[player setStep:(int)(y/320.0*8.0) stepValue:(int)(x/320.0*8.0)];
}
-(void)touchUp:(float)x y:(float)y touchId:(int)touchId{
}

@end