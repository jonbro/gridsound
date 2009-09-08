//
//  mainController.mm
//  mujik
//
//  Created by jonbroFERrealz on 8/30/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "mainController.h"


@implementation mainController
@synthesize parentC, bankC, menuC, helpC, infoC;

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
	
	return self;
}
-(void)initialStart
{
	currentView = menuC;
	[self addSubview:menuC];
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
@end
