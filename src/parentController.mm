//
//  parent_controller.mm
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 4/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "parentController.h"
#include "ofMain.h"

@implementation parentController

-(id) initWithSongData:_songData mainFont:_font;
{
	[super init];
	songData = _songData;
	font = font;
	return self;
}
-(void) render
{
	// do nothing
}
@end
