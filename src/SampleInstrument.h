//
//  SampleInstrument.h
//  RemoteIOTest
//
//  Created by Jonathan Brodsky on 3/27/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "InMemoryAudioFile.h"
#import "TunableFilter.h"

@interface SampleInstrument : NSObject {
	float	sampleIndex, delta;
	int		note;
	int		volume;
	int		cutoff;
	float	loopStart;
	float	loopEnd;
	bool	dirty;
	int		packetIndex;
	int		packetCount;
	float	volMultiplier;
	NSMutableArray *samplePool;
	int possibleNotes[8];
	InMemoryAudioFile *currentSampleObject;
	int		currentSample;
	NSMutableDictionary *controllers;
	TunableFilter *leftFilter;
	TunableFilter *rightFilter;
	SInt16 *leftChannel, *rightChannel, halfSize;
	float	f_leftChannel, f_rightChannel;
	
}

@property bool	dirty;
@property int	note;
@property int	volume;
@property int	currentSample;
@property float loopStart;
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
