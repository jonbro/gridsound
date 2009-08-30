//
//  bankController.mm
//  mujik
//
//  Created by jonbroFERrealz on 8/22/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "bankController.h"
#include "globals.h"

@implementation bankController
-(id)init
{
	self = [super init];
	myShape = new ofxMSAShape3D();
	bankData = [[NSMutableArray alloc]initWithCapacity:0];
	NSBundle* myBundle = [NSBundle mainBundle];
	int nBanks = DIR.listDir("banks");
	for(int i = 0; i < nBanks; i++){
		NSString *bank_path = [[NSString alloc] initWithCString:DIR.getPath(i).c_str()];
		NSString *path = [NSBundle pathForResource:@"bank_info" ofType:@"plist" inDirectory:bank_path];
		NSMutableDictionary *bank_info = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
		[bank_info setObject:bank_path forKey:@"bank_path"];
		GLButton *bankButton = [[[GLButton alloc] initWithFrame:CGRectMake(6, 6+48*i, 200, 45)]retain];
		[bank_info setObject:bankButton forKey:@"bank_button"];
		bankButton._delegate = self;
		[bankButton setColor:0x000000];
		[bankButton setFontColor:0xFFFFFF];
		[bankButton setTitle:[bank_info objectForKey:@"bank_name"]];
		[self addSubview:bankButton];
		[bankData addObject:bank_info];
    }
	return self;
}
-(void)buttonDidPress:(GLButton *)_button
{
	for(int i=0;i<[bankData count];i++){
		if([[bankData objectAtIndex:i] objectForKey:@"bank_button"] == _button){
			[self loadBank:[NSNumber numberWithInt:i]];
			break;
		}
	}
}
-(void)loadBank:(NSNumber*)bankNumber
{
	// pause the player
	[player stop];
	NSLog(@"start load");
	// destroy whatever is in the bank
	for (int i=0; i<[player.samplePool count]; i++) {
		[[player.samplePool objectAtIndex:i]release];
	}
	[player.samplePool removeAllObjects];
	// load up the new bank
	// load the plist from the selected bank
	
	NSArray *sampleArray = [[bankData objectAtIndex:[bankNumber intValue]]objectForKey:@"samples"];
	for(int i=0;i<[sampleArray count];i++){
		InMemoryAudioFile *inMemoryAudioFile = [[InMemoryAudioFile alloc]init];
		[inMemoryAudioFile open:[NSBundle pathForResource:[sampleArray objectAtIndex:i] ofType:@"wav" inDirectory:[[bankData objectAtIndex:[bankNumber intValue]]objectForKey:@"bank_path"]]];
		[player.samplePool addObject:inMemoryAudioFile];
	}
	for(int i=0;i<[player.samplePool count];i++){
		NSLog(@"sample in pool: %@", [[player.samplePool objectAtIndex:i] path]);
	}
	player.bpm = [[[bankData objectAtIndex:[bankNumber intValue]] objectForKey:@"bpm"] floatValue];
	player.bankInfo = [bankData objectAtIndex:[bankNumber intValue]];
	[player start];
	NSLog(@"bank number retain count: %i", [bankNumber retainCount]);
}
-(void)setPlayer:(RemoteIOPlayer *)_player
{
	player = _player;
}
-(void)touchDown:(TouchEvent *)_tEvent
{
	NSLog(@"pressed");
}
@end
