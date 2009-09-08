//
//  infoController.mm
//  mujik
//
//  Created by jonbroFERrealz on 9/7/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "infoController.h"


@implementation infoController
-(id)init
{
	self = [super init];
	
	backButton = [[GLButton alloc] initWithFrame:CGRectMake(0, 177, 107, 99)];
	backButton._delegate = self;
	backButton.visible = false;
	[self addSubview:backButton];

	webButton = [[GLButton alloc] initWithFrame:CGRectMake(107, 420, 213, 60)];
	webButton._delegate = self;
	webButton.visible = false;
	[self addSubview:webButton];
	
	return self;
}
-(void)buttonDidPress:(GLButton *)_button
{
	if(backButton == _button){
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"switchToMenu" object:self];		
	}
	if(webButton == _button){
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.luckyframe.co.uk"]];
	}
}	
-(void)render
{
	wallHelper->drawRect(0, 0, 320, 480, 683, 480, 1);
	[super render];
}
@end
