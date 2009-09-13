//
//  GLbankButton.h
//  mujik
//
//  Created by jonbroFERrealz on 9/13/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomEventResponder.h"
#import "ofMain.h"
#import "GLButton.h"
#import "TransformUtils.h"
#import "globals.h"

@interface GLbankButton : GLButton {
	NSString	*author_title;
}
@property int color;

-(void)setAuthorTitle:(NSString *)_title;

@end
