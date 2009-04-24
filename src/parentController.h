//
//  parentController.h
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 4/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "ofMain.h"

//#import "phraseController.h"

@interface parentController : NSObject {
	NSArray *songData;
	ofTrueTypeFont *font;
}

-(id) initWithSongData;
-(void) render;

@end
