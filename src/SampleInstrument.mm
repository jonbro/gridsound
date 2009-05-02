//
//  SampleInstrument.m
//  RemoteIOTest
//
//  Created by jonbroFERrealz on 3/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SampleInstrument.h"

@implementation SampleInstrument

@synthesize note;
@synthesize volume;
@synthesize dirty;
@synthesize loopStart;
@synthesize controllers;
@synthesize currentSample;
@synthesize samplePool;

float loopStart = 0;
int note = 0;
float sampleIndex = 0;
-(id)init
{
	[super init];
	leftFilter = [[TunableFilter alloc]init];
	[leftFilter setRes:0.1f];
	[leftFilter setCutoff:1000.0f];
	rightFilter = [[TunableFilter alloc]init];
	[rightFilter setRes:(float)2.0f];
	[rightFilter setCutoff:(float)1000.0f];
	[self setNote:0];
	controllers = [[NSMutableDictionary alloc] initWithCapacity:1];
	possibleNotes[0] = -3;
	possibleNotes[1] = 0;
	possibleNotes[2] = 2;
	possibleNotes[3] = 4;
	possibleNotes[4] = 7;
	possibleNotes[5] = 9;
	possibleNotes[6] = 11;
	possibleNotes[7] = 12;
	halfSize = sizeof(SInt16)/2;
	packetIndex = 0;
	leftChannel = (SInt16 *)malloc(sizeof(SInt16));
	rightChannel = (SInt16 *)malloc(sizeof(SInt16));
	return self;
}

//gets the next packet from the buffer, if we have reached the end of the buffer return 0
-(void)getNextPacket:(UInt32 *)returnValue{

	// 	 float* src_ptr_1;
	// 	 float* src_ptr_2;
	// 	 float* dst_ptr;
	
	
	sampleIndex = delta + sampleIndex;
	if(sampleIndex>loopEnd){
		sampleIndex = loopStart;
	}
	
	packetIndex = packetCount*sampleIndex;

//	// nearest neighbor interpolation

	f_leftChannel = [currentSampleObject getPacket:packetIndex];
	f_rightChannel = [currentSampleObject getPacket:packetIndex+1];
	[leftFilter processSample:&f_leftChannel];
	[rightFilter processSample:&f_rightChannel];

	*leftChannel = (int)(f_leftChannel*volMultiplier);
	*rightChannel = (int)(f_rightChannel*volMultiplier);
	*returnValue = *rightChannel+(*leftChannel<<16);
}
-(void)setNote:(int)_note
{
	note = possibleNotes[_note];
	[self fixDelta];
}
-(void)setCutoff:(int)_cutoff
{
	// LO (FUCKING) L
	switch(_cutoff)
	{
		case 0:
			[rightFilter setRes:2.0f];
			[rightFilter setCutoff:100.0];
			[leftFilter setRes:2.0f];
			[leftFilter setCutoff:100.0];
			break;			
		case 1:
			[rightFilter setRes:2.0f];
			[rightFilter setCutoff:300.0];
			[leftFilter setRes:2.0f];
			[leftFilter setCutoff:300.0];
			break;
		case 2:
			[rightFilter setRes:2.0f];
			[rightFilter setCutoff:600.0];
			[leftFilter setRes:2.0f];
			[leftFilter setCutoff:600.0];
			break;
		case 3:
			[rightFilter setRes:1.0f];
			[rightFilter setCutoff:900.0];
			[leftFilter setRes:1.0f];
			[leftFilter setCutoff:900.0];
			break;
		case 4:
			[rightFilter setRes:1.0f];
			[rightFilter setCutoff:1200.0];
			[leftFilter setRes:1.0f];
			[leftFilter setCutoff:1200.0];
			break;
		case 5:
			[rightFilter setRes:1.0f];
			[rightFilter setCutoff:4000.0];
			[leftFilter setRes:1.0f];
			[leftFilter setCutoff:4000.0];
			break;
		case 6:
			[rightFilter setRes:0.5f];
			[rightFilter setCutoff:8000.0];
			[leftFilter setRes:0.5f];
			[leftFilter setCutoff:8000.0];
			break;
		case 7:
			[rightFilter setRes:0.25f];
			[rightFilter setCutoff:10000.0];
			[leftFilter setRes:0.23f];
			[leftFilter setCutoff:10000.0];
			break;
			
		default:
			break;
			
	}
}
-(void)setVolume:(int)_volume
{
	volume = _volume;
	volMultiplier = volume/255.0;
}
-(void)setCurrentSample:(int)_currentSample
{
	currentSample = _currentSample;
	currentSampleObject = [samplePool objectAtIndex:currentSample];
}
-(void)setLoopOffsetStartPercentage:(float)startPercentage endPercentage:(float)endPercentage
{
	loopStart = startPercentage;
	loopEnd = endPercentage;
}
-(void)fixDelta
{
	float num_packets = pow(2, (float)(note+12)/12.0f);
	packetCount = [currentSampleObject getPacketCount];
	delta = num_packets/(float)packetCount;
}
-(void)reset
{
	sampleIndex = loopStart;
	packetCount = [currentSampleObject getPacketCount];
	[self fixDelta];
}

@end
