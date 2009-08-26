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
#import "ofxMSAShape3D.h"
#import "CustomEventResponder.h"
#import "GLButton.h"

@interface bankController : CustomEventResponder {
	RemoteIOPlayer *player;
	NSMutableArray *bankData;
	ofxDirList DIR;
	ofImage atlas;
	ofTexture atlasTex;
	ofxMSAShape3D *myShape;
}
-(void)render;
-(void)loadBank:(NSNumber*)bankNumber;
-(void)setPlayer:(RemoteIOPlayer *)_player;
@end
