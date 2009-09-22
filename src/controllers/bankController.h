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
#import "bankModel.h"
#import "appModel.h"
#import "parentModel.h"
#import "globals.h"
#import "GLbankButton.h"

#define degreesToRadians(x) (M_PI * x / 180.0)

@interface bankController : CustomEventResponder {
	RemoteIOPlayer *player;
	int currentBank;
	NSMutableArray *bankData;
	NSMutableArray *bankButtons;
	GLButton *exitButton;
	GLbankButton *testBankButton;
	ofxDirList DIR;
	bankModel *bModel;
	appModel *aModel;
	ofxMSAShape3D *myShape;
}

@property (retain) bankModel *bModel;

-(void)render;
-(void)loadBank:(NSNumber*)bankNumber;
-(void)setModel:(bankModel*)_bModel;
-(void)setAppModel:(appModel*)_aModel;
-(parentModel*)loadParent:(int)_parentNumber;
-(void)saveParent:(parentModel*)_pModel atIndex:(int)_index;
-(void)loadBankByName:(NSMutableString*)bankName;
-(void)setPlayer:(RemoteIOPlayer *)_player;
@end
