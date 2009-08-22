//
//  bankController.mm
//  mujik
//
//  Created by jonbroFERrealz on 8/22/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "bankController.h"


@implementation bankController
-(id)init
{
	self = [super init];
	bankData = [[NSMutableArray alloc]initWithCapacity:0];
	NSBundle* myBundle = [NSBundle mainBundle];
	int nBanks = DIR.listDir("banks");
	NSLog(@"%d", nBanks);
	for(int i = 0; i < nBanks; i++){
		NSString *bank_path = [[NSString alloc] initWithCString:DIR.getPath(i).c_str()];
		NSString *path = [NSBundle pathForResource:@"bank_info" ofType:@"plist" inDirectory:bank_path];
		NSMutableDictionary *bank_info = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
		[bank_info setObject:bank_path forKey:@"bank_path"];
		[bankData addObject:bank_info];
    }	
	return self;
}
-(void)render
{
	
}
-(void)loadBank:(NSNumber*)bankNumber
{
	// pause the player
	[player stop];
	// destroy whatever is in the bank
	for(int i=0;i<[player.samplePool count];i++){
		[[player.samplePool objectAtIndex:i]dealloc];
		[player.samplePool removeObjectAtIndex:i];
	}
	// load up the new bank
	// load the plist from the selected bank
	
	NSArray *sampleArray = [[bankData objectAtIndex:bankNumber]objectForKey:@"samples"];
	NSLog(@"%@", sampleArray);
	NSLog([[bankData objectAtIndex:2]objectForKey:@"bank_path"]);
	for(int i=0;i<[sampleArray count];i++){
		InMemoryAudioFile *inMemoryAudioFile = [[InMemoryAudioFile alloc]init];
		[inMemoryAudioFile open:[NSBundle pathForResource:[sampleArray objectAtIndex:i] ofType:@"wav" inDirectory:[[bankData objectAtIndex:bankNumber]objectForKey:@"bank_path"]]];
		[player.samplePool addObject:[inMemoryAudioFile retain]];
	}
	player.bpm = [[[bankData objectAtIndex:bankNumber] objectForKey:@"bpm"] floatValue];
	[player start];
}
-(void)setPlayer:(RemoteIOPlayer *)_player
{
	player = _player;
}
@end
