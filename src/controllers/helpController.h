//
//  helpController.h
//  mujik
//
//  Created by jonbroFERrealz on 9/5/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomEventResponder.h"
#import "GLButton.h"
#import "ofMain.h"
#import "wallFolderHelper.h"
#import "globals.h"

@interface helpController : CustomEventResponder <GLButtonDelegate> {
	GLButton *bookButton, *wallButton, *backButton;
	bool onWall, onBook;
}

-(void)addButtons;
-(void)removeButtons;

@end
