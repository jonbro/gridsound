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
@synthesize loopStart;

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
	[rightFilter setCutoff:(float)100.0f];
	return self;
}
- (OSStatus) getFileInfo {
	OSStatus status = [super getFileInfo];
	volume = 255;
	loopEnd = (float)packetCount;
	return status;
}

//gets the next packet from the buffer, if we have reached the end of the buffer return 0
-(UInt32)getNextPacket{
	
	UInt32 returnValue = 0;
	
	sampleIndex += pow(2, (float)note/12.0f);
	//if the packetCount has gone to the end of the file, reset it. Audio will loop.
	if (sampleIndex >= loopEnd){
		sampleIndex = loopStart;
		packetIndex = loopStart;
		cutoff = fmod(cutoff+200, 10000);
//		[leftFilter setCutoff:(float)cutoff];
//		[leftFilter calc];
		//note--;
		//NSLog(@"Reset player to beginning of file.");
	}
	
	//i always like to set a variable and then return it during development so i can
	//see the value while debugging
	
	// nearest neighbor interpolation
	float intHolder;
	if(modff(sampleIndex, &intHolder) > 0.5){
		packetIndex = ceil(sampleIndex);
	}else{
		packetIndex = floor(sampleIndex);
	}
	returnValue = audioData[packetIndex];

	// mute one of the channels
	SInt16 leftChannel = returnValue>>16;
	SInt16 rightChannel = returnValue&0xFFFF;
	float volMultiplier = ((float)volume)/255.0;

	rightChannel = rightChannel*volMultiplier;
	leftChannel  = leftChannel*volMultiplier;
		
	// pass the left channel throught the filter
	
	leftChannel = [leftFilter processSample:leftChannel];
	rightChannel = [rightFilter processSample:rightChannel];
	/* rightChannel = [filter processSample:rightChannel]; */
//	leftChannel = leftChannel + 0xFF;
//	rightChannel = rightChannel + 0xFF;
//	
	returnValue = ((UInt32)rightChannel)+(((UInt32)leftChannel)<<16);
	
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
