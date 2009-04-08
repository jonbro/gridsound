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
	TunableFilter *filter;
}

@property float sampleIndex;
@property int	note;
@property int	volume;
@property float loopStart;


//gets the next packet from the buffer, returns -1 if we have reached the end of the buffer
-(UInt32)getNextPacket;
-(OSStatus)getFileInfo;
-(void)reset;
-(void)setLoopOffsetStartPercentage:(float)startPercentage endPercentage:(float)endPercentage;

//gets the current index (where we are up to in the buffer)
//-(SInt64)getIndex;

@end
