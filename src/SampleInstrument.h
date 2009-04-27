//
//  SampleInstrument.h
//  RemoteIOTest
//
//  Created by Jonathan Brodsky on 3/27/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "InMemoryAudioFile.h"
#import "TunableFilter.h"

@interface SampleInstrument : InMemoryAudioFile {
	float	sampleIndex;
	int		note;
	int		volume;
	int		cutoff;
	float	loopStart;
	float	loopEnd;
	float	delta;
	bool	dirty;
	float volMultiplier;
	NSMutableDictionary *controllers;
	TunableFilter *leftFilter;
	TunableFilter *rightFilter;
	SInt16 *leftChannel, *rightChannel, halfSize;
	float	f_leftChannel, f_rightChannel;
	
}

@property bool	dirty;
@property float sampleIndex;
@property int	note;
@property int	volume;
@property float loopStart;
@property (assign) NSMutableDictionary* controllers;

//gets the next packet from the buffer, returns -1 if we have reached the end of the buffer
-(void)getNextPacket:(UInt32 *)returnValue;
-(OSStatus)getFileInfo;
-(void)reset;
-(void)setLoopOffsetStartPercentage:(float)startPercentage endPercentage:(float)endPercentage;

//gets the current index (where we are up to in the buffer)
//-(SInt64)getIndex;

@end
