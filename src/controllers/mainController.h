//
//  mainController.h
//  mujik
//
//  Created by jonbroFERrealz on 8/30/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomEventResponder.h"
#import "bankController.h"
#import "parentController.h"
#import "menuController.h"
#import "helpController.h"
#import "infoController.h"
#import "phraseController.h"
#import "appModel.h"

@interface mainController : CustomEventResponder {
	bankController *bankC;
	parentController *parentC;
	menuController *menuC;
	helpController *helpC;
	infoController *infoC;
	phraseController *phraseC;
	appModel *aModel;
	CustomEventResponder *currentView;
}

@property (nonatomic, retain) bankController *bankC;
@property (nonatomic, retain) parentController *parentC;
@property (nonatomic, retain) menuController *menuC;
@property (nonatomic, retain) helpController *helpC;
@property (nonatomic, retain) infoController *infoC;
@property (nonatomic, retain) phraseController *phraseC;

-(void)switchToBank:(NSNotification *)notification;
-(void)switchToMain:(NSNotification *)notification;
-(void)switchToHelp:(NSNotification *)notification;
-(void)switchToInfo:(NSNotification *)notification;
-(void)switchToPhraseSave:(NSNotification *)notification;
-(void)switchToPhraseLoad:(NSNotification *)notification;

-(void)initialStart;
-(void)setApp:(appModel*)_aModel;
-(void)switchToMenu:(NSNotification *)notification;

@end
