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
	controllers = [[NSMutableDictionary alloc] initWithCapacity:1];
	return self;
}
- (OSStatus) getFileInfo {
	OSStatus status = [super getFileInfo];
	volume = 128;
	loopEnd = (float)packetCount;
	return status;
}

//gets the next packet from the buffer, if we have reached the end of the buffer return 0
-(UInt32)getNextPacket{
	
	UInt32 returnValue = 0;

	sampleIndex += pow(2, (float)note/12.0f);
	if (sampleIndex >= loopEnd){
		sampleIndex = loopStart;
		packetIndex = loopStart;
	}
	
	// nearest neighbor interpolation
	float intHolder;
	if(modff(sampleIndex, &intHolder) > 0.5){
		packetIndex = ceil(sampleIndex);
	}else{
		packetIndex = floor(sampleIndex);
	}
	returnValue = audioData[packetIndex];
// should put all of this in a loop
	SInt16 leftChannel = (SInt16)(returnValue>>16);
	SInt16 rightChannel = (SInt16)(returnValue&0xFFFF);
	
	leftChannel = leftChannel-sizeof(SInt16)/2;
	rightChannel = rightChannel-sizeof(SInt16)/2;
	
	float volMultiplier = volume/255.0;
	
	leftChannel = ((float)leftChannel)*volMultiplier;
	rightChannel = ((float)rightChannel)*volMultiplier;
	
	leftChannel = leftChannel+sizeof(SInt16)/2;
	rightChannel = rightChannel+sizeof(SInt16)/2;
	returnValue = (leftChannel<<16)+rightChannel;

	return returnValue;
}

-(void)setLoopOffsetStartPercentage:(float)startPercentage endPercentage:(float)endPercentage
{
	loopStart = (float)packetCount*startPercentage;
	loopEnd = (float)packetCount*endPercentage;
}
-(void)reset{
	sampleIndex = loopStart;
}
//-(SInt64)getIndex;

@end
