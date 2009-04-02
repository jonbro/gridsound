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
	int tick;
	int frameCounter;
}

//@property (nonatomic, retain) SampleInstrument *inMemoryAudioFile[];
@property (nonatomic, retain) NSMutableArray *instrumentGroup;
@property int tick;
@property int frameCounter;

-(OSStatus)start;
-(OSStatus)stop;
-(void)cleanUp;
-(void)intialiseAudio;

@end
