//
//  parentController.h
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 4/10/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "gridController.h"
#include "ofMain.h"
#include "ofxiPhoneKeyboard.h"

//#import "phraseController.h"

@interface parentController : NSObject {
	bool renderSmall;
	int currentGrid;
	NSMutableArray	*children;
}

@property (assign) NSMutableArray* children;

-(void)render;
-(void)addChild:(NSObject *)_child;
-(void)touchDownX:(float)x y:(float)y touchId:(int)touchId;
-(void)touchMoved:(float)x y:(float)y touchId:(int)touchId;
-(void)touchUp:(float)x y:(float)y touchId:(int)touchId;

@end
