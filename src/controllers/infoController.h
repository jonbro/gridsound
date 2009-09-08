//
//  infoController.h
//  mujik
//
//  Created by jonbroFERrealz on 9/7/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomEventResponder.h"
#import "GLButton.h"
#import "ofMain.h"
#import "wallFolderHelper.h"
#import "globals.h"

@interface infoController : CustomEventResponder <GLButtonDelegate> {
	GLButton *webButton, *backButton;
}

@end
