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
	note = 0;
	cutoff = 44100.0;
	res = 2;
	hasNote = false;
	return self;
}

@end
