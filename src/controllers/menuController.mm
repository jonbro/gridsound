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
	
	return self;
}
-(void)buttonDidPress:(GLButton *)_button
{
	NSLog(@"the button %@", _button);
	if(bankButton == _button){
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"switchToBank" object:self];
	}
}
-(void)render
{
	main_menu.draw(0, 0, 320, 480);
	[super render];
}
-(void)touchDown:(TouchEvent *)_tEvent
{
	NSLog(@"testing thing %@", bankButton.frame);
	NSLog(@"pressed x: %f y: %f", _tEvent.pos.x, _tEvent.pos.y);
}

@end
