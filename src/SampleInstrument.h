//
//  SampleInstrument.h
//  RemoteIOTest
//
//  Created by Jonathan Brodsky on 3/27/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "InMemoryAudioFile.h"
#import "TunableFilter.h"
#import "MoogFilter2.h"
#include "fixed.h"

@interface SampleInstrument : NSObject {
	Newfixed	fpDelta, fpPos;
	int		sampleIndex, loopStart, loopEnd;
	int		note;
	int		volume;
	int		cutoff;
	bool	filtering;
	int		packetIndex;
	int		packetCount;
	NSMutableArray *samplePool;
	int possibleNotes[8];
	InMemoryAudioFile *currentSampleObject;
	int		currentSample;
	NSMutableDictionary *controllers;
	MoogFilter2 *leftFilter;
	MoogFilter2 *rightFilter;
	SInt16 *leftChannel, *rightChannel;
	Float32 fl_leftChan, fl_rightChan, volMultiplier;
	Newfixed f_leftChan, f_rightChan;
}

@property int	note;
@property int	volume;
@property int	currentSample;
@property (assign) NSMutableArray* samplePool;
@property (retain) NSMutableDictionary* controllers;

//gets the next packet from the buffer, returns -1 if we have reached the end of the buffer
-(void)getNextPacket:(UInt32 *)returnValue;
-(void)reset;
-(void)fixDelta;
-(void)setCutoff:(int)_cutoff;
-(void)setLoopOffsetStartPercentage:(float)startPercentage endPercentage:(float)endPercentage;

//gets the current index (where we are up to in the buffer)
//-(SInt64)getIndex;

@end
