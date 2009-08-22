//
//  RemoteIOPlayer.m
//  RemoteIOTest
//
//  Created by aran Mulholland on 3/03/09.
//  Copyright 2009 Aran Mulholland. All rights reserved.
//

#import "RemoteIOPlayer.h"
#include <AudioUnit/AudioUnit.h>

#define kOutputBus 0
#define kInputBus 1

@implementation RemoteIOPlayer

@synthesize instrumentGroup, samplePool, bpm;
@synthesize offsetArray;
@synthesize tick;
@synthesize frameCounter;

int frameCounter = 0;
int tick = 0;

AudioComponentInstance audioUnit;
AudioStreamBasicDescription audioFormat;
-(id)init
{
	self = [super init];
	bpm = 107;
	samplePool = [[NSMutableArray alloc]initWithCapacity:3];
	return self;
}
-(OSStatus)start{
	
	OSStatus status = AudioOutputUnitStart(audioUnit);
	return status;
}

-(OSStatus)stop{
	OSStatus status = AudioOutputUnitStop(audioUnit);
	//RemoteIOPlayer *remoteIOplayer = (RemoteIOPlayer *)inRefCon;
	return status;
}

-(void)cleanUp{
	AudioUnitUninitialize(audioUnit);
}


/* Parameters on entry to this function are :-
 
 *inRefCon - used to store whatever you want, can use it to pass in a reference to an objectiveC class
 i do this below to get at the InMemoryAudioFile object, the line below :
 callbackStruct.inputProcRefCon = self;
 in the initialiseAudio method sets this to "self" (i.e. this instantiation of RemoteIOPlayer).
 This is a way to bridge between objectiveC and the straight C callback mechanism, another way
 would be to use an "evil" global variable by just specifying one in theis file and setting it
 to point to inMemoryAudiofile whenever it is set.
 
 *inTimeStamp - the sample time stamp, can use it to find out sample time (the sound card time), or the host time
 
 inBusnumber - the audio bus number, we are only using 1 so it is always 0 
 
 inNumberFrames - the number of frames we need to fill. In this example, because of the way audioformat is
 initialised below, a frame is a 32 bit number, comprised of two signed 16 bit samples.
 
 *ioData - holds information about the number of audio buffers we need to fill as well as the audio buffers themselves */
static OSStatus playbackCallback(void *inRefCon, 
								 AudioUnitRenderActionFlags *ioActionFlags, 
								 const AudioTimeStamp *inTimeStamp, 
								 UInt32 inBusNumber, 
								 UInt32 inNumberFrames, 
								 AudioBufferList *ioData) {  
	
	
	
	//get a copy of the objectiveC class "self" we need this to get the next sample to fill the buffer
	RemoteIOPlayer *remoteIOplayer = (RemoteIOPlayer *)inRefCon;
	
	//loop through all the buffers that need to be filled
	SInt16 leftChannel = 0;
	SInt16 rightChannel = 0;
	UInt32 *nextPacket;	
	Float32 startPercentage;
	Float32 endPercentage;
	int currentTick = 0;
	int remainder = 0;
	int groupCount = [[remoteIOplayer instrumentGroup] count];
	float beatLength = 22050.0*60/remoteIOplayer.bpm;
	
	for (int i = 0 ; i < ioData->mNumberBuffers; i++){
		//get the buffer to be filled
		
		AudioBuffer buffer = ioData->mBuffers[i];
		UInt32 *frameBuffer = buffer.mData;
		
		//loop through the buffer and fill the frames
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		for (int j = 0; j < inNumberFrames; j++){
			rightChannel = 0;
			leftChannel = 0;
			frameCounter++;
			remainder = fmod(frameCounter, beatLength);			

			// loop through all of the instruments
			if(remainder == 0){
				remoteIOplayer.tick++;
				currentTick = fmod(remoteIOplayer.tick, 8);
				
				for(int k=0;k<groupCount;k++) {
					//should move this into the sample player to save on instantiation
					SampleInstrument *samplePlayer = [[remoteIOplayer instrumentGroup] objectAtIndex:k];
					if([samplePlayer.controllers objectForKey:@"lpof"] != nil){
						[samplePlayer setCurrentSample:[[samplePlayer.controllers objectForKey:@"lpof"] getSample]];
						startPercentage = ((Float32)[[samplePlayer.controllers objectForKey:@"lpof"] getStep:currentTick])/8;
						[samplePlayer setNote:1];
						[samplePlayer setVolume:[[samplePlayer.controllers objectForKey:@"lpof"] volumeLevel]];
						[samplePlayer setDirection:[[samplePlayer.controllers objectForKey:@"lpof"] getDirection]];
					}
					endPercentage = startPercentage+1/(8.0*([[samplePlayer.controllers objectForKey:@"rtgr"] getStep:currentTick]+1));
					if([samplePlayer.controllers objectForKey:@"note"] != nil){	
						[samplePlayer setNote:[[samplePlayer.controllers objectForKey:@"note"] getStep:currentTick]];
					}
					[samplePlayer setLoopOffsetStartPercentage:startPercentage endPercentage:endPercentage];
					[samplePlayer reset];					
				}
			}
			nextPacket = &frameBuffer[j];
			for(int k=0;k<groupCount;k++) {
				SampleInstrument *samplePlayer = [[remoteIOplayer instrumentGroup] objectAtIndex:k];
				[samplePlayer getNextPacket:nextPacket];
				leftChannel += (SInt16)(*nextPacket>>16);
			}
			*nextPacket = (UInt32)(leftChannel+sizeof(UInt32)/2)+((UInt32)leftChannel+sizeof(UInt32)/2<<16);
		}
		[pool release];
	}
    return noErr;
}

-(void)setStep:(int)i stepValue:(int)j
{
	steps[i] = j;
}

-(int)getStep:(int)i
{
	return steps[i];
}
// Below code is a cut down version (for output only) of the code written by
// Micheal "Code Fighter" Tyson (punch on Mike)
// See http://michael.tyson.id.au/2008/11/04/using-remoteio-audio-unit/ for details
-(void)intialiseAudio{
	OSStatus status;
	
	
	// Describe audio component
	AudioComponentDescription desc;
	desc.componentType = kAudioUnitType_Output;
	desc.componentSubType = kAudioUnitSubType_RemoteIO;
	desc.componentFlags = 0;
	desc.componentFlagsMask = 0;
	desc.componentManufacturer = kAudioUnitManufacturer_Apple;
	
	// Get component
	AudioComponent inputComponent = AudioComponentFindNext(NULL, &desc);
	
	// Get audio units
	status = AudioComponentInstanceNew(inputComponent, &audioUnit);
	
	UInt32 flag = 1;
	// Enable IO for playback
	status = AudioUnitSetProperty(audioUnit, 
								  kAudioOutputUnitProperty_EnableIO, 
								  kAudioUnitScope_Output, 
								  kOutputBus,
								  &flag, 
								  sizeof(flag));
	
	// Describe format
//	audioFormat.mSampleRate = 44100.0;
//	audioFormat.mFormatID = kAudioFormatLinearPCM;
//	audioFormat.mFormatFlags  = kAudioFormatFlagsAudioUnitCanonical;
//	audioFormat.mBytesPerPacket = sizeof(AudioUnitSampleType);
//	audioFormat.mFramesPerPacket = 1;
//	audioFormat.mBytesPerFrame = sizeof(AudioUnitSampleType);
//	audioFormat.mChannelsPerFrame = 1;
//	audioFormat.mBitsPerChannel = 8 * sizeof(AudioUnitSampleType);
//	audioFormat.mReserved = 0;
	
	audioFormat.mSampleRate			= 22050.0;
	audioFormat.mFormatID			= kAudioFormatLinearPCM;
	audioFormat.mFormatFlags		= kAudioFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked;
// the original
	audioFormat.mFramesPerPacket	= 1;
	audioFormat.mChannelsPerFrame	= 2;
	audioFormat.mBitsPerChannel		= 16;
	audioFormat.mBytesPerPacket		= 4;
	audioFormat.mBytesPerFrame		= 4;
	
	//Apply format
	status = AudioUnitSetProperty(audioUnit, 
								  kAudioUnitProperty_StreamFormat, 
								  kAudioUnitScope_Input, 
								  kOutputBus, 
								  &audioFormat, 
								  sizeof(audioFormat));
	
	// Set up the playback  callback
	AURenderCallbackStruct callbackStruct;
	callbackStruct.inputProc = playbackCallback;
	//set the reference to "self" this becomes *inRefCon in the playback callback
	callbackStruct.inputProcRefCon = self;
	
	status = AudioUnitSetProperty(audioUnit, 
								  kAudioUnitProperty_SetRenderCallback, 
								  kAudioUnitScope_Global, 
								  kOutputBus,
								  &callbackStruct, 
								  sizeof(callbackStruct));
	
	// Initialise
	status = AudioUnitInitialize(audioUnit);
	
	
	//notice i do nothing with status, i should error check.
}

-(void)setMuteChannel:(int)i
{
	toMute[i] = !toMute[i];
	//just a line
}
-(bool)getMute:(int)i
{
	return toMute[i];
}

@end
