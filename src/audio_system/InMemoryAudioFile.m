//
//  InMemoryAudioFile.m
//  HelloWorld
//
//  Created by Aran Mulholland on 22/02/09.
//  Copyright 2009 Aran Mulholland. All rights reserved.
//

#import "InMemoryAudioFile.h"

@implementation InMemoryAudioFile

- (void)dealloc {
	//release the AudioBuffer
	free(audioData);
    [super dealloc];
}
-(UInt32)getPacket:(int)packetIndex
{
	return audioData[packetIndex];
}
-(int)getPacketCount
{
	return packetCount;
}
//open and read a wav file
-(OSStatus)open:(NSString *)filePath{
	
	//print out the file path
//	NSLog(@"FilePath: ");
//	NSLog(filePath);
	
	//get a ref to the audio file, need one to open it
	CFURLRef audioFileURL = CFURLCreateFromFileSystemRepresentation (NULL, (const UInt8 *)[filePath cStringUsingEncoding:[NSString defaultCStringEncoding]] , strlen([filePath cStringUsingEncoding:[NSString defaultCStringEncoding]]), false);
	
	//open the audio file
	OSStatus result = AudioFileOpenURL (audioFileURL, kAudioFileWAVEType, 0, &mAudioFile);
	//were there any errors reading? if so deal with them first
	if (result != noErr) {
//		NSLog([NSString stringWithFormat:@"Could not open file: %s", filePath]);
		packetCount = -1;
	}
	//otherwise
	else{
		//get the file info
		[self getFileInfo];
		//how many packets read? (packets are the number of stereo samples in this case)
//		NSLog([NSString stringWithFormat:@"File Opened, packet Count: %d", packetCount]);
		
		UInt32 packetsRead = packetCount;
		OSStatus result = -1;
		
		//free the audioBuffer just in case it contains some data
		free(audioData);
		UInt32 numBytesRead = -1;
		//if we didn't get any packets dop nothing, nothing to read
		if (packetCount <= 0) { }
		//otherwise fill our in memory audio buffer with the whole file (i wouldnt use this with very large files btw)
		else{
			//allocate the buffer
			audioData = (UInt32 *)malloc(sizeof(UInt32) * packetCount);
			//read the packets
			result = AudioFileReadPackets(mAudioFile, false, &numBytesRead, NULL, 0, &packetsRead,  audioData);
			// jam our audio data into a float thingu... this is probably a BAAAADDD IDEA!
			// for now we assume stereo samples, there is probably a way to determine this....
		}
		if (result==noErr){
			//print out general info about  the file
//			NSLog([NSString stringWithFormat:@"Packets read from file: %d\n", packetsRead]);
//			NSLog([NSString stringWithFormat:@"Bytes read from file: %d\n", numBytesRead]);
//			//for a stereo 32 bit per sample file this is ok
//			NSLog([NSString stringWithFormat:@"Sample count: %d\n", numBytesRead / 2]);
//			//for a 32bit per stereo sample at 44100khz this is correct
//			NSLog([NSString stringWithFormat:@"Time in Seconds: %f.4\n", ((float)numBytesRead / 4.0) / 44100.0]);
		}
	}
	
	CFRelease (audioFileURL);     
	
	return result;
}

- (OSStatus) getFileInfo {
	
	OSStatus	result = -1;
	double duration;
	
	if (mAudioFile == nil){}
	else{
		UInt32 dataSize = sizeof(packetCount);
		result = AudioFileGetProperty(mAudioFile, kAudioFilePropertyAudioDataPacketCount, &dataSize, &packetCount);
		if (result==noErr) {
			duration = ((double)packetCount * 2) / 44100;
		}
		else{
			packetCount = -1;
		}
	}
	return result;
}
@end
