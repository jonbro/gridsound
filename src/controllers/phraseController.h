//
//  phrase_controller.h
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 4/10/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomEventResponder.h"
#import "GLButton.h"
#import "ofMain.h"
#import "wallFolderHelper.h"
#import "globals.h"
#import "bankController.h"
#import "parentController.h"

@interface phraseController : CustomEventResponder <GLButtonDelegate> {
	NSMutableArray *phraseSet;
	GLButton *backButton, *clearPhrase, *confirm, *cancel;
	bankController *bankC;
	parentController *parentC;
	NSMutableArray *phraseButtons;
	bool loading, toDialog, atDialog, tweenDirection, tweening;
	int dialogStart, direction, dialog_pos, jar_to_save, fadeStart, jar_to_load;
}

@property (assign) bool loading;

-(void)setBankController:(bankController*)_bankC;
-(void)setParentController:(parentController*)_parentC;
-(void)renderHighlight;

@end
