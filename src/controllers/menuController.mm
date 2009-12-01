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

	buyButton = [[GLButton alloc] initWithFrame:CGRectMake(93, 171, 224, 176)];
	buyButton._delegate = self;
	buyButton.visible = false;
	[self addSubview:buyButton];
	
	helpButton = [[GLButton alloc] initWithFrame:CGRectMake(96, 404, 224, 76)];
	helpButton._delegate = self;
	helpButton.visible = false;
	[self addSubview:helpButton];
	
	infoButton = [[GLButton alloc] initWithFrame:CGRectMake(96, 349, 224, 55)];
	infoButton._delegate = self;
	infoButton.visible = false;
	[self addSubview:infoButton];
	
	return self;
}
-(void)buttonDidPress:(GLButton *)_button
{
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
	if(buyButton == _button){
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.luckyframe.co.uk/mujik"]];
	}
}
-(void)render
{
	wallHelper->drawRect(0, 0, 320, 480, 256, 384, 768, 0, 2);
	[super render];
}
@end
