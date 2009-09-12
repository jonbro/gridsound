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
	transitionDirection = true;
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
	[bankC setModel:aModel.currentBank];
	[bankC setAppModel:aModel];
	[bankC loadBankByName:aModel.currentBank.bankName];
	
	[phraseC setBankController:bankC];
	[phraseC setParentController:parentC];
	
	[[NSNotificationCenter defaultCenter]
	 postNotificationName:aModel.currentScreen object:self];
	[parentC setModel:aModel.currentBank.currentParent];

}
-(void)switchToBank:(NSNotification *)notification
{
	[self startTransition];
	[self removeSubview:currentView];
	currentView = bankC;
	aModel.currentScreen = [NSMutableString stringWithString:@"switchToBank"];
	[self addSubview:bankC];
}
-(void)switchToMain:(NSNotification *)notification
{
	[self startTransition];
	[self removeSubview:currentView];
	currentView = parentC;
	aModel.currentScreen = [NSMutableString stringWithString:@"switchToMain"];
	[self addSubview:parentC];
}
-(void)switchToHelp:(NSNotification *)notification
{
	[self startTransition];
	[self removeSubview:currentView];
	currentView = helpC;
	aModel.currentScreen = [NSMutableString stringWithString:@"switchToHelp"];
	[self addSubview:helpC];
}
-(void)switchToInfo:(NSNotification *)notification
{
	[self startTransition];
	[self removeSubview:currentView];
	currentView = infoC;
	aModel.currentScreen = [NSMutableString stringWithString:@"switchToInfo"];
	[self addSubview:infoC];
}
-(void)switchToMenu:(NSNotification *)notification
{
	[self startTransitionBack];
	[self removeSubview:currentView];
	currentView = menuC;
	aModel.currentScreen = [NSMutableString stringWithString:@"switchToMenu"];
	[self addSubview:menuC];
}
-(void)switchToPhraseSave:(NSNotification *)notification
{
	[self startTransition];
	[self removeSubview:currentView];
	currentView = phraseC;
	phraseC.loading = false;
	aModel.currentScreen = [NSMutableString stringWithString:@"switchToPhraseSave"];
	[self addSubview:phraseC];
}
-(void)switchToPhraseLoad:(NSNotification *)notification
{
	[self startTransition];
	[self removeSubview:currentView];
	currentView = phraseC;
	phraseC.loading = true;
	aModel.currentScreen = [NSMutableString stringWithString:@"switchToPhraseLoad"];
	[self addSubview:phraseC];
}
-(void)startTransition
{
	transitioning = true;
	transitionDirection = false;
	transition_pos = 0;
	transitionStart = ofGetElapsedTimeMillis();
	outgoingView = currentView;
}
-(void)startTransitionBack
{
	transitioning = true;
	transitionDirection = true;
	transition_pos = 0;
	transitionStart = ofGetElapsedTimeMillis();
	outgoingView = currentView;	
}
-(void)render
{
	if(transitioning){
		glPushMatrix();
		if(transitionDirection){
			glTranslatef(transition_pos, 0, 0);
			[outgoingView render];
			glTranslatef(-320, 0, 0);
			[currentView render];
		}else{
			glTranslatef(-transition_pos, 0, 0);
			[outgoingView render];
			glTranslatef(320, 0, 0);
			[currentView render];
		}
		glPopMatrix();			
		transition_pos += ((ofGetElapsedTimeMillis()-transitionStart)/20);;
		if(transition_pos >= 320){
			transition_pos = 0;
			transitioning = false;
		}
		[super removeSubviewTask];
		[super addSubviewTask];
	}else{
		[super render];
	}
}
@end
