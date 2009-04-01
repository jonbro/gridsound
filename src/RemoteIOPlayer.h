//
//  RemoteIOPlayer.h
//  RemoteIOTest
//
//  Created by Aran Mulholland on 3/03/09.
//  Copyright 2009 Aran Mulholland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InMemoryAudioFile.h"
#import "SampleInstrument.h"

@interface RemoteIOPlayer : NSObject {
	SampleInstrument *inMemoryAudioFile;
	int tick;
	int frameCounter;
}

@property (nonatomic, retain) SampleInstrument *inMemoryAudioFile;
@property int tick;
@property int frameCounter;

-(OSStatus)start;
-(OSStatus)stop;
-(void)cleanUp;
-(void)intialiseAudio;

@end
