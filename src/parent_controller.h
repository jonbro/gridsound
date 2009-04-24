//
//  parentController.h
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 4/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "phraseController.h"
@interface parentController : NSObject {
	NSArray *songData;
	ofTrueTypeFont *font;
}

-(id) initWithSongData:(NSArray)_songData mainFont:(ofTrueTypeFont)_font;
-(void) render;

@end
