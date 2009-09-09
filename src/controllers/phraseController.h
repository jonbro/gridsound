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
	GLButton *backButton, *clearPhrase;
	bankController *bankC;
	parentController *parentC;
	bool loading;
}

@property (assign) bool loading;

-(void)setBankController:(bankController*)_bankC;
-(void)setParentController:(parentController*)_parentC;

@end
