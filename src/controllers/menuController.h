//
//  mainController.h
//  mujik
//
//  Created by jonbroFERrealz on 8/30/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomEventResponder.h"
#import "GLButton.h"
#import "ofMain.h"
#import "wallFolderHelper.h"
#import "globals.h"

@interface menuController : CustomEventResponder <GLButtonDelegate> {
	// do I even need to maintain any kind of state here? I don't think so...
	GLButton *bankButton, *helpButton, *infoButton, *phraseLoadButton, *phraseSaveButton, *backButton;
}

@end
