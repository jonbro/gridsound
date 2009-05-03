//
//  InMemoryAudioFile.h
//  HelloWorld
//
//  Created by Aran Mulholland on 22/02/09.
//  Copyright 2009 Aran Mulholland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioFile.h>
#include <sys/time.h>
#include "fixed.h"

@interface InMemoryAudioFile : NSObject {
	AudioStreamBasicDescription		mDataFormat;                    
    AudioFileID						mAudioFile;                     
    UInt32							bufferByteSize;                 
    SInt64							mCurrentPacket;                 
    UInt32							mNumPacketsToRead;              
    AudioStreamPacketDescription	*mPacketDescs;                  
	SInt64							packetCount;
	UInt32							*audioData;	
}
//opens a wav file
-(OSStatus)open:(NSString *)filePath;
-(UInt32)getPacket:(int)packetIndex;
-(Newfixed)getFixedPacket:(int)packetIndex;
//gets the info about a wav file, stores it locally
-(OSStatus)getFileInfo;

-(int)getPacketCount;

@end
