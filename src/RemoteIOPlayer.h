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
	//SampleInstrument *inMemoryAudioFile[];
	NSMutableArray *instrumentGroup;
	NSMutableArray *offsetArray;
	int tick;
	int frameCounter;
	int steps[8];
}

//@property (nonatomic, retain) SampleInstrument *inMemoryAudioFile[];
@property (nonatomic, retain) NSMutableArray *instrumentGroup;
@property (nonatomic, retain) NSMutableArray *offsetArray;
@property int tick;
@property int frameCounter;

-(OSStatus)start;
-(OSStatus)stop;
-(void)setStep:(int)i stepValue:(int)j;
-(int)getStep:(int)i;

-(void)cleanUp;
-(void)intialiseAudio;

@end
