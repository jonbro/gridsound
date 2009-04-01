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

int note = 0;
float sampleIndex = 0;

//gets the next packet from the buffer, if we have reached the end of the buffer return 0
-(UInt32)getNextPacket{
	
	UInt32 returnValue = 0;
	
	sampleIndex += pow(2, (float)note/12.0f);
	//if the packetCount has gone to the end of the file, reset it. Audio will loop.
	if (packetIndex >= packetCount){
		packetIndex = 0;
		sampleIndex = 0;
		//note--;
		//NSLog(@"Reset player to beginning of file. from sample instrument");
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
	
	return returnValue;
}
//-(SInt64)getIndex;

@end
