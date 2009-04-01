//
//  Phrase.m
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 3/31/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Phrase.h"


@implementation Phrase

- (id)init 
{ 
    [super init]; 
	//set the index
	for(int i=0;i<16;i++){
		notes[i] = 0;
	}
	return self;
}

-(void) setStep:(int)_step :(int)_note{
	notes[_step] = _note;
}
-(int) getStep:(int)_step{
	return notes[_step];
}

@end
