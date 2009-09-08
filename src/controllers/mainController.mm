//
//  mainController.mm
//  mujik
//
//  Created by jonbroFERrealz on 8/30/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "mainController.h"


@implementation mainController
@synthesize parentC, bankC, menuC, helpC, infoC, phraseC;

-(id)init
{
	self = [super init];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(switchToBank:)
												 name:@"switchToBank" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(switchToMain:)
												 name:@"switchToMain" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(switchToMenu:)
												 name:@"switchToMenu" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(switchToHelp:)
												 name:@"switchToHelp" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(switchToInfo:)
												 name:@"switchToInfo" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(switchToPhraseLoad:)
												 name:@"switchToPhraseLoad" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(switchToPhraseSave:)
												 name:@"switchToPhraseSave" object:nil];
	
	return self;
}
-(void)initialStart
{
	currentView = menuC;
	[self addSubview:menuC];
}
// loads the proper bank
// passes off the information about the currently running phrase to the parent controller
// then go to the proper screen

-(void)setApp:(appModel*)_aModel
{
	
	aModel = _aModel;
	// should roll this into a "setModel" reciever
	[bankC loadBankByName:aModel.currentBank.bankName];
	[[NSNotificationCenter defaultCenter]
	 postNotificationName:aModel.currentScreen object:self];
	[parentC setModel:aModel.currentBank.currentParent];

}
-(void)switchToBank:(NSNotification *)notification
{
	[self removeSubview:currentView];
	currentView = bankC;
	[self addSubview:bankC];
}
-(void)switchToMain:(NSNotification *)notification
{
	[self removeSubview:currentView];
	currentView = parentC;
	[self addSubview:parentC];
}
-(void)switchToHelp:(NSNotification *)notification
{
	[self removeSubview:currentView];
	currentView = helpC;
	[self addSubview:helpC];
}
-(void)switchToInfo:(NSNotification *)notification
{
	[self removeSubview:currentView];
	currentView = infoC;
	[self addSubview:infoC];
}
-(void)switchToMenu:(NSNotification *)notification
{
	[self removeSubview:currentView];
	currentView = menuC;
	[self addSubview:menuC];
}
-(void)switchToPhraseSave:(NSNotification *)notification
{
	[self removeSubview:currentView];
	currentView = phraseC;
	[self addSubview:phraseC];
}
-(void)switchToPhraseLoad:(NSNotification *)notification
{
	[self removeSubview:currentView];
	currentView = phraseC;
	[self addSubview:phraseC];
}

@end
