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
	SampleInstrument *samplePlayer;
	NSMutableArray *instrumentGroup;
	NSMutableArray *offsetArray;
	NSMutableArray *samplePool;
	NSDictionary *bankInfo;
	float bpm;
	int tick;
	bool toMute[2];
	bool playing;
	int frameCounter;
	int steps[8];
}

//@property (nonatomic, retain) SampleInstrument *inMemoryAudioFile[];
@property (nonatomic, retain) NSMutableArray *instrumentGroup;
@property (nonatomic, retain) NSMutableArray *samplePool;
@property (nonatomic, retain) NSMutableArray *offsetArray;
@property (nonatomic, retain) NSDictionary *bankInfo;
@property int tick;
@property float bpm;
@property bool playing;
@property int frameCounter;

-(OSStatus)start;
-(OSStatus)stop;
-(void)setStep:(int)i stepValue:(int)j;
-(int)getStep:(int)i;

-(bool)getMute:(int)i;
-(void)setMuteChannel:(int)i;

-(void)cleanUp;
-(void)intialiseAudio;

@end
