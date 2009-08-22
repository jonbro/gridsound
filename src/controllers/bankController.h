//
//  bankController.h
//  mujik
//
//  Created by jonbroFERrealz on 8/22/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RemoteIOPlayer.h"
#import "ofMain.h"
#include "ofxDirList.h"

@interface bankController : NSObject {
	RemoteIOPlayer *player;
	NSMutableArray *bankData;
	ofxDirList DIR;
}
-(void)render;
-(void)loadBank:(NSNumber*)bankNumber;
-(void)setPlayer:(RemoteIOPlayer *)_player;
@end
