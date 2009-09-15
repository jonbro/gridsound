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
	for(int i = 0; i < nBanks; i++){
		NSString *bank_path = [[NSString alloc] initWithCString:DIR.getPath(i).c_str()];
		NSString *path = [NSBundle pathForResource:@"bank_info" ofType:@"plist" inDirectory:bank_path];
		NSMutableDictionary *bank_info = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
		[bank_info setObject:bank_path forKey:@"bank_path"];
		GLbankButton *bankButton = [[[GLbankButton alloc] initWithFrame:CGRectMake(0, 0, 217, 320)]retain];
		
		if(i==0){
			[bankButton setColor:0xFFFFFF];
			bankButton.currentTranslation = CGAffineTransformTranslate(bankButton.currentTranslation, 167, 20);
			bankButton.currentTranslation = CGAffineTransformRotate(bankButton.currentTranslation, degreesToRadians(10));
		}else if(i==1){
			[bankButton setColor:0xEECCCC];
			bankButton.currentTranslation = CGAffineTransformTranslate(bankButton.currentTranslation, 0, 114);
		}else if(i==2){
			[bankButton setColor:0xCCEECC];
			bankButton.currentTranslation = CGAffineTransformTranslate(bankButton.currentTranslation, 156, 133);
			bankButton.currentTranslation = CGAffineTransformRotate(bankButton.currentTranslation, degreesToRadians(7));
		}else if(i==3){
			[bankButton setColor:0xFFFFFF];
			bankButton.currentTranslation = CGAffineTransformTranslate(bankButton.currentTranslation, 96, 248);
			bankButton.currentTranslation = CGAffineTransformRotate(bankButton.currentTranslation, degreesToRadians(-5));
		}
		
		[bank_info setObject:bankButton forKey:@"bank_button"];
		bankButton._delegate = self;
		[bankButton setFontColor:0xFFFFFF];
		[bankButton setTitle:[bank_info objectForKey:@"bank_name"]];
		[bankButton setAuthorTitle:[bank_info objectForKey:@"author_name"]];
		NSLog([bank_info objectForKey:@"author_name"]);
		[self addSubview:bankButton];
		[bankData addObject:bank_info];
    }
	exitButton = [[[GLButton alloc] initWithFrame:CGRectMake(6, 400, 200, 45)]retain];
	exitButton._delegate = self;
	[exitButton setColor:0x000000];
	[exitButton setFontColor:0xFFFFFF];
	[exitButton setTitle:[NSString stringWithString:@"Exit"]];
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

	}else{
		for(int i=0;i<[bankData count];i++){
			if([[bankData objectAtIndex:i] objectForKey:@"bank_button"] == _button){
				[self loadBank:[NSNumber numberWithInt:i]];
				[bModel release];
				bModel = [[aModel loadBank:[[bankData objectAtIndex:i] objectForKey:@"bank_name"]]retain];
				break;
			}
		}
	}
}
-(void)render
{
	//background
	wallHelper->drawRect(0, 0, 320, 480, 256, 384, 256, 0, 3);
	[super render];
	//buttons
//	wallHelper->setColor(0xDDEEDD);
//	wallHelper->drawRect(0, 0, 255, 380, 521, 9, 3);
//	//foreground
	//[testBankButton render];
	wallHelper->setColor(0xFFFFFF);
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
	// pause the player
	//[player stop];
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
	//if(loaded){
		//[player start];
	//}else{
//		ofSleepMillis(1000);
//		[self loadBank:bankNumber];
//	}
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
