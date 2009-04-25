/*
 *  gridController.h
 *  iPhone Graphics Example
 *
 *  Created by jonbroFERrealz on 4/24/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>
#import "RemoteIOPlayer.h"
#include "ofMain.h"

@interface gridController : NSObject {
	int steps[8];
	RemoteIOPlayer *player;
}

-(id) init:(RemoteIOPlayer *)_player;
-(void)draw;

-(void)touchDownX:(float)x y:(float)y touchId:(int)touchId;
-(void)touchMoved:(float)x y:(float)y touchId:(int)touchId;
-(void)touchUp:(float)x y:(float)y touchId:(int)touchId;

@end
