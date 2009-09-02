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

@interface menuController : CustomEventResponder <GLButtonDelegate> {
	// do I even need to maintain any kind of state here? I don't think so...
	ofImage main_menu;
	NSMutableDictionary *menuButtons;
	GLButton *bankButton;
}

@end
