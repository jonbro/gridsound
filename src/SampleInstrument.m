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
@synthesize sampleIndex;
@synthesize volume;
@synthesize dirty;
@synthesize loopStart;
@synthesize controllers;

float loopStart = 0;
int note = 0;
float sampleIndex = 0;

-(id)init
{
	[super init];
	leftFilter = [[TunableFilter alloc]init];
	[leftFilter setRes:1.0f];
	[leftFilter setCutoff:1000.0f];
	cutoff = 200;
	rightFilter = [[TunableFilter alloc]init];
	[rightFilter setRes:(float)2.0f];
	[rightFilter setCutoff:(float)4410.0];
	[self setNote:0];
	controllers = [[NSMutableDictionary alloc] initWithCapacity:1];
	halfSize = sizeof(SInt16)/2;
	return self;
}
- (OSStatus) getFileInfo {
	OSStatus status = [super getFileInfo];
	loopEnd = (float)packetCount;
	return status;
}

//gets the next packet from the buffer, if we have reached the end of the buffer return 0
-(void)getNextPacket:(UInt32 *)returnValue{
	
	sampleIndex += delta;
	packetIndex = (int)sampleIndex;
	if (packetIndex >= loopEnd){
		sampleIndex = loopStart;
		packetIndex = loopStart;
	}

//	// nearest neighbor interpolation
	float intHolder;
	if(modff(sampleIndex, &intHolder) > 0.5){
		packetIndex = ceil(sampleIndex);
	}else{
		packetIndex = floor(sampleIndex);
	}
	*returnValue = audioData[packetIndex];
	
	leftChannel = (SInt16*)returnValue+sizeof(SInt16);
	rightChannel = (SInt16*)returnValue;
	f_leftChannel = (float)*leftChannel;
	f_rightChannel = (float)*rightChannel;
	*leftChannel = (int)(f_leftChannel*volMultiplier);
	*rightChannel = (int)(f_rightChannel*volMultiplier);
	*returnValue = *rightChannel+(*leftChannel<<16);
}
-(void)setNote:(int)_note
{
	note = _note;
	delta = pow(2, (float)note/12.0f);
}
-(void)setVolume:(int)_volume
{
	volume = _volume;
	volMultiplier = volume/255.0;
}
-(void)setLoopOffsetStartPercentage:(float)startPercentage endPercentage:(float)endPercentage
{
	loopStart = (float)packetCount*startPercentage;
	loopEnd = (float)packetCount*endPercentage;
}
-(void)reset{
	sampleIndex = loopStart;
}

@end
