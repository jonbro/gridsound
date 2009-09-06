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
	main_menu.loadImage("main_menu.png");
	menuButtons = [[NSMutableDictionary alloc] init];
	
	bankButton = [[GLButton alloc] initWithFrame:CGRectMake(101, 200, 209, 45)];
	bankButton._delegate = self;
	bankButton.visible = false;
	[self addSubview:bankButton];

	helpButton = [[GLButton alloc] initWithFrame:CGRectMake(128, 396, 184, 49)];
	helpButton._delegate = self;
	helpButton.visible = false;
	[self addSubview:helpButton];
	
	backButton = [[GLButton alloc] initWithFrame:CGRectMake(103, 16, 204, 100)];
	backButton._delegate = self;
	backButton.visible = false;
	[self addSubview:backButton];
	
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
	if(backButton == _button){
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"switchToMain" object:self];		
	}
}
-(void)render
{
	main_menu.draw(0, 0, 320, 480);
	[super render];
}
@end
