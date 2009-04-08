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
	filter = [[MoogFilter alloc]init];
	filter.cutoff = 0.2;
	filter.res = 0;
	[filter calc];
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
	
	int leftChannel = returnValue>>16;
	int rightChannel = returnValue&0xFFFF;
	
	float volMultiplier = ((float)volume)/255.0;
	rightChannel = ((float)rightChannel)*volMultiplier;
	leftChannel  = ((float)leftChannel)*volMultiplier;
	
	// pass the left channel throught the filter
	leftChannel = (int)[filter process:(float)leftChannel];
	rightChannel = (int)[filter process:(float)rightChannel];

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
