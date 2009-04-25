/*
 *  gridController.h
 *  iPhone Graphics Example
 *
 *  Created by jonbroFERrealz on 4/24/09.
 *  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
 *
 */
#pragma once
#include "ofMain.h"
#import <Foundation/Foundation.h>
#import "RemoteIOPlayer.h"
#import "parentController.h"

@interface gridController : NSObject {
	int steps[8];
	RemoteIOPlayer *player;
}

-(id) init:(RemoteIOPlayer *)_player;
-(void)render;
-(int)getStep:(int)_step;
-(void)drawBottomBar;
-(void)touchDownX:(float)x y:(float)y touchId:(int)touchId;
-(void)touchMoved:(float)x y:(float)y touchId:(int)touchId;
-(void)touchUp:(float)x y:(float)y touchId:(int)touchId;

@end
