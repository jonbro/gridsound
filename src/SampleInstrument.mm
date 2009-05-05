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
	[leftFilter setRes:(float)2.0f];
	[leftFilter setCutoff:(float)1000.0f];
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
	fpPos = i2fp(0);
	filtering = true;
	packetIndex = 0;
	leftChannel = (SInt16 *)malloc(sizeof(SInt16));
	rightChannel = (SInt16 *)malloc(sizeof(SInt16));
	return self;
}

//gets the next packet from the buffer, if we have reached the end of the buffer return 0
-(void)getNextPacket:(UInt32 *)returnValue{
	// update samples position
	fpPos = fp_add(fpDelta, fpPos);
	packetIndex = packetIndex + fp2i(fpPos);
	fpPos &= FP_FRACMASK;
	
	//check to make sure we are within range
	if(packetIndex > loopEnd){
		packetIndex = loopStart;
	}

	//get the return value
	*returnValue = [currentSampleObject getPacket:packetIndex];
	
	leftChannel = (SInt16 *)returnValue;
	rightChannel = &leftChannel[1];
	// do all my shit in fp
	f_leftChan = i2fp((*leftChannel));
	f_rightChan = i2fp((*rightChannel));
	
	f_leftChan = fp_mul(volMultiplier, f_leftChan);
	f_rightChan = fp_mul(volMultiplier, f_rightChan);
	if(filtering){
		[leftFilter processSample:&f_leftChan];
		[rightFilter processSample:&f_rightChan];
	}
	*leftChannel = (SInt16)fp2i(f_leftChan);
	*rightChannel = (SInt16)fp2i(f_leftChan);
	
}
-(void)setNote:(int)_note
{
	note = possibleNotes[_note];
	[self fixDelta];
}
-(void)setCutoff:(int)_cutoff
{
	if(_cutoff >= 7){
		filtering = false;
	}else{
		filtering = true;
		_cutoff = (int)400.0*(pow(2, (float)(_cutoff*3+12)/12.0f));
		[rightFilter setCutoff:_cutoff];
		[leftFilter setCutoff:_cutoff];
	}
}
-(void)setRes:(int)_res
{
	[rightFilter setRes:((float)(255-_res)/255.0)*2.0];
	[leftFilter setRes:((float)(255-_res)/255.0)*2.0];
}
-(void)setVolume:(int)_volume
{
	volume = _volume;
	volMultiplier = fl2fp((float)volume/255.0);
}
-(void)setCurrentSample:(int)_currentSample
{
	currentSample = _currentSample;
	currentSampleObject = [samplePool objectAtIndex:currentSample];
}
-(void)setLoopOffsetStartPercentage:(float)startPercentage endPercentage:(float)endPercentage
{
	loopStart = [currentSampleObject getPacketCount]*startPercentage;
	loopEnd = [currentSampleObject getPacketCount]*endPercentage;
}
-(void)fixDelta
{
	fpDelta = fl2fp(pow(2, (float)(note+12)/12.0f));
}
-(void)reset
{
	packetIndex = loopStart;
	packetCount = [currentSampleObject getPacketCount];
	[self fixDelta];
}

@end
