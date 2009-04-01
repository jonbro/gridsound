//
//  Phrase.h
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 3/31/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Phrase : NSObject {
	int notes[16];
}
-(void) setStep:(int)_step :(int)_note;
-(int) getStep:(int)_step;
@end
