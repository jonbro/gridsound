//
//  menuController.mm
//  mujik
//
//  Created by jonbroFERrealz on 9/1/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "menuController.h"


@implementation menuController
-(id)init
{
	self = [super init];
	
	backButton = [[GLButton alloc] initWithFrame:CGRectMake(77, 111, 243, 61)];
	backButton._delegate = self;
	backButton.visible = false;
	[self addSubview:backButton];

	bankButton = [[GLButton alloc] initWithFrame:CGRectMake(77, 172, 243, 54)];
	bankButton._delegate = self;
	bankButton.visible = false;
	[self addSubview:bankButton];

	phraseSaveButton = [[GLButton alloc] initWithFrame:CGRectMake(77, 226, 243, 52)];
	phraseSaveButton._delegate = self;
	phraseSaveButton.visible = false;
	[self addSubview:phraseSaveButton];
	
	phraseLoadButton = [[GLButton alloc] initWithFrame:CGRectMake(77, 278, 243, 56)];
	phraseLoadButton._delegate = self;
	phraseLoadButton.visible = false;
	[self addSubview:phraseLoadButton];
	
	helpButton = [[GLButton alloc] initWithFrame:CGRectMake(128, 334, 184, 56)];
	helpButton._delegate = self;
	helpButton.visible = false;
	[self addSubview:helpButton];
	
	infoButton = [[GLButton alloc] initWithFrame:CGRectMake(77, 390, 243, 62)];
	infoButton._delegate = self;
	infoButton.visible = false;
	[self addSubview:infoButton];
	
	return self;
}
-(void)buttonDidPress:(GLButton *)_button
{
	if(bankButton == _button){
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"switchToBank" object:self];
	}
	if(helpButton == _button){
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"switchToHelp" object:self];		
	}
	if(infoButton == _button){
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"switchToInfo" object:self];		
	}
	if(backButton == _button){
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"switchToMain" object:self];		
	}
	if(phraseSaveButton == _button){
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"switchToPhraseSave" object:self];		
	}
	if(phraseLoadButton == _button){
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"switchToPhraseLoad" object:self];		
	}
}
-(void)render
{
	wallHelper->drawRect(0, 0, 320, 480, 256, 384, 768, 0, 2);
	[super render];
}
@end
