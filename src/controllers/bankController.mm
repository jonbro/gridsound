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
@synthesize bModel;
-(id)init
{
	self = [super init];
	myShape = new ofxMSAShape3D();
	bankData = [[NSMutableArray alloc]initWithCapacity:0];
	NSBundle* myBundle = [NSBundle mainBundle];
	int nBanks = DIR.listDir("banks");
	bankButtons = [[NSMutableArray alloc] initWithCapacity:0];
	for(int i = 0; i < nBanks; i++){
		NSString *bank_path = [[NSString alloc] initWithCString:DIR.getPath(i).c_str()];
		NSString *path = [NSBundle pathForResource:@"bank_info" ofType:@"plist" inDirectory:bank_path];
		NSMutableDictionary *bank_info = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
		[bank_info setObject:bank_path forKey:@"bank_path"];
		GLbankButton *bankButton = [[[GLbankButton alloc] initWithFrame:CGRectMake(0, 0, 217, 320)]retain];
		[bankButton setColor:0xFFFFFF];
		
		if(i==0){
			bankButton.currentTranslation = CGAffineTransformTranslate(bankButton.currentTranslation, 127, 20);
			bankButton.currentTranslation = CGAffineTransformRotate(bankButton.currentTranslation, degreesToRadians(10));
		}else if(i==1){
			bankButton.currentTranslation = CGAffineTransformTranslate(bankButton.currentTranslation, 0, 114);
		}else if(i==2){
			bankButton.currentTranslation = CGAffineTransformTranslate(bankButton.currentTranslation, 156, 133);
			bankButton.currentTranslation = CGAffineTransformRotate(bankButton.currentTranslation, degreesToRadians(7));
		}else if(i==3){
			bankButton.currentTranslation = CGAffineTransformTranslate(bankButton.currentTranslation, 96, 248);
			bankButton.currentTranslation = CGAffineTransformRotate(bankButton.currentTranslation, degreesToRadians(-5));
		}
		
		[bank_info setObject:bankButton forKey:@"bank_button"];
		bankButton._delegate = self;
		[bankButton setFontColor:0xFFFFFF];
		[bankButton setTitle:[bank_info objectForKey:@"bank_name"]];
		[bankButton setAuthorTitle:[bank_info objectForKey:@"author_name"]];
		NSLog([bank_info objectForKey:@"author_name"]);
		[bankData addObject:bank_info];
		[bankButtons addObject:bankButton];
    }
	exitButton = [[[GLButton alloc] initWithFrame:CGRectMake(14, 190, 77, 78)]retain];
	exitButton._delegate = self;
	exitButton.visible = false;
	[self addSubview:exitButton];
	
//	testBankButton = [[GLbankButton alloc] initWithFrame:CGRectMake(0, 0, 217, 320)];
//	testBankButton.currentTranslation = CGAffineTransformRotate(testBankButton.currentTranslation, degreesToRadians(45));
//	[self addSubview:testBankButton];
	
	return self;
}
// putting this here because I need to run it on the current bank object
-(parentModel*)loadParent:(int)_parentNumber
{
	return [bModel.phraseSet objectAtIndex:_parentNumber];
}
-(void)saveParent:(parentModel*)_pModel atIndex:(int)_index
{
	[bModel.phraseSet insertObject:[_pModel copy] atIndex:_index];
}
-(void)buttonDidPress:(GLButton *)_button
{
	if(_button == exitButton){
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"switchToMenu" object:self];

	}
}
-(void)render
{
	//background
	wallHelper->drawRect(0, 0, 320, 480, 256, 384, 256, 0, 3);
	//bank cards
	for(int i=0;i<[bankButtons count];i++){
		[[bankButtons objectAtIndex:i] render];
	}
	//back button
	wallHelper->drawRect(14, 190, 77, 78, 0, 384, 3);
	[super render];
	wallHelper->setColor(0xFFFFFF);
	// foreground
	wallHelper->drawRect(0, 0, 320, 480, 256, 384, 0, 0, 3);
}
-(void)setModel:(bankModel*)_bModel
{
	[bModel release];
	bModel = [_bModel retain];
}
-(void)setAppModel:(appModel*)_aModel
{
	[aModel release];
	aModel = [_aModel retain];
}
-(void)loadBankByName:(NSMutableString*)bankName
{
	for(int i=0;i<[bankData count];i++){
		if([[[bankData objectAtIndex:i] objectForKey:@"bank_name"] isEqualToString:bankName]){
			[self loadBank:[NSNumber numberWithInt:i]];
			break;
		}
	}
}
-(void)loadBank:(NSNumber*)bankNumber
{
	if(currentBank != [bankNumber intValue]){
		currentBank = [bankNumber intValue];
		// pause the player
		[player pause];
		// check the internal state of the player
		while (player.internalPlaying) {
			NSLog(@"waiting to stop");
		}
		// wipe all the bank colors
		for(int i=0;i<[bankButtons count];i++){
			[(GLButton*)[bankButtons objectAtIndex:i] setColor:0xFFFFFF];
		}
		[(GLButton*)[bankButtons objectAtIndex:[bankNumber intValue]] setColor:0xCCEECC];
		// destroy whatever is in the bank
		for (int i=0; i<[player.samplePool count]; i++) {
			[[player.samplePool objectAtIndex:i]release];
		}
		[player.samplePool removeAllObjects];
		// load up the new bank
		// load the plist from the selected bank
		
		bModel.bankName = [NSMutableString stringWithString:[[bankData objectAtIndex:[bankNumber intValue]]objectForKey:@"bank_name"]];
		
		NSArray *sampleArray = [[bankData objectAtIndex:[bankNumber intValue]]objectForKey:@"samples"];
		NSLog(@"sample array: %@", sampleArray);
		bool loaded = true;
		for(int i=0;i<[sampleArray count];i++){
			InMemoryAudioFile *inMemoryAudioFile = [[InMemoryAudioFile alloc]init];
			[player.samplePool addObject:inMemoryAudioFile];
			[inMemoryAudioFile open:[NSBundle pathForResource:[sampleArray objectAtIndex:i] ofType:@"wav" inDirectory:[[bankData objectAtIndex:[bankNumber intValue]]objectForKey:@"bank_path"]]];
		}
		player.bpm = [[[bankData objectAtIndex:[bankNumber intValue]] objectForKey:@"bpm"] floatValue];
		player.bankInfo = [bankData objectAtIndex:[bankNumber intValue]];
		[player unpause];
	}
}
-(void)setPlayer:(RemoteIOPlayer *)_player
{
	player = _player;
}
-(void)touchDown:(TouchEvent *)_tEvent
{
	int touchedButton;
	bool buttonTouched = false;
	for(int i=0;i<[bankButtons count];i++){
		if([[bankButtons objectAtIndex:i] insideX:_tEvent.pos.x Y:_tEvent.pos.y]){
			buttonTouched = true;
			touchedButton = i;
		}
	}
	if(buttonTouched){
		[self loadBank:[NSNumber numberWithInt:touchedButton]];
		[bModel release];
		bModel = [[aModel loadBank:[[bankData objectAtIndex:touchedButton] objectForKey:@"bank_name"]]retain];		
	}
	NSLog(@"pressed");
}
@end
