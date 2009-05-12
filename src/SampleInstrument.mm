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
	leftFilter = [[MoogFilter2 alloc]init];
	rightFilter = [[MoogFilter2 alloc]init];
	[self setNote:0];
	controllers = [[NSMutableDictionary alloc] initWithCapacity:1];
	[self setRes:255];
	[self setCutoff:7];
	possibleNotes[0] = -3;
	possibleNotes[1] = 0;
	possibleNotes[2] = 2;
	possibleNotes[3] = 4;
	possibleNotes[4] = 7;
	possibleNotes[5] = 9;
	possibleNotes[6] = 11;
	possibleNotes[7] = 12;
	fpPos = i2fp(0);
	filtering = false;
	packetIndex = 0;
	leftChannel = (SInt16 *)malloc(sizeof(SInt16));
	rightChannel = (SInt16 *)malloc(sizeof(SInt16));
//	fl_leftChan = (Float32 *)malloc(sizeof(Float32));
//	fl_rightChan = (Float32 *)malloc(sizeof(Float32));
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
	fl_leftChan = (Float32)(*leftChannel);
//	fl_rightChan = (Float32)(*rightChannel);
	fl_leftChan = fl_leftChan/65535.0;
//	fl_rightChan = fl_rightChan/65535.0;

	if(filtering){
		[leftFilter processSample:&fl_leftChan];
		//[rightFilter processSample:&fl_rightChan];
	}

	fl_leftChan = volMultiplier*fl_leftChan;
//	fl_rightChan = volMultiplier*fl_rightChan;
	fl_rightChan = fl_leftChan;
	*leftChannel = (SInt16)(fl_leftChan*65535.0);
	*rightChannel = (SInt16)(fl_rightChan*65535.0);
	
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
		[rightFilter setCutoff:((float)(_cutoff+1))/8.0];
		[leftFilter setCutoff:((float)(_cutoff+1))/8.0];
	}
}
-(void)setCutoffDirect:(float)_cutoff
{
	if(_cutoff == 0.5){
		filtering = false;
	}else{
		filtering = true;
		[self setRes:100];
		[rightFilter setCutoff:_cutoff];
		[leftFilter setCutoff:_cutoff];
	}
	
}
-(void)setRes:(int)_res
{
	[rightFilter setRes:((float)(255-_res)/255.0)];
	[leftFilter setRes:((float)(255-_res)/255.0)];
}
-(void)setVolume:(int)_volume
{
	volume = _volume;
	volMultiplier = (float)volume/255.0;
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
