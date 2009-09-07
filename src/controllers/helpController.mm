//
//  helpController.mm
//  mujik
//
//  Created by jonbroFERrealz on 9/5/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "helpController.h"

@implementation helpController
-(id)init
{
	self = [super init];

	backButton = [[GLButton alloc] initWithFrame:CGRectMake(13, 187, 78, 82)];
	backButton._delegate = self;
	backButton.visible = false;

	bookButton = [[GLButton alloc] initWithFrame:CGRectMake(113, 236, 188, 47)];
	bookButton._delegate = self;
	bookButton.visible = false;
	
	wallButton = [[GLButton alloc] initWithFrame:CGRectMake(104, 155, 202, 55)];
	wallButton._delegate = self;
	wallButton.visible = false;
	
	onWall = false;
	onBook = false;
	
	[self addButtons];
	
	return self;
}
-(void)addButtons
{
	[self addSubview:backButton];
	[self addSubview:bookButton];
	[self addSubview:wallButton];
}
-(void)removeButtons
{
	[self removeSubview:backButton];
	[self removeSubview:bookButton];
	[self removeSubview:wallButton];
}
-(void)buttonDidPress:(GLButton *)_button
{
	if(backButton == _button){
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"switchToMenu" object:self];		
	}
	if(wallButton == _button){
		onWall = true;
		[self removeButtons];
	}
	if(bookButton == _button){
		onBook = true;
		[self removeButtons];
	}
}
-(void)render
{
	if(onWall){
		wallHelper->drawRect(0, 0, 320, 480, 256, 384, 256, 0, 2);
	}else if(onBook){
		wallHelper->drawRect(0, 0, 320, 480, 256, 384, 0, 0, 2);
	}else{
		wallHelper->drawRect(0, 0, 320, 480, 256, 384, 512, 0, 2);
	}
}
//-(void)touchDown:(TouchEvent *)_tEvent
//{
//	if(onWall||onBook){
//		onWall == false;
//		onBook == false;
//		[self addButtons];
//	}
//}

@end
