//
//  phrase_controller.mm
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 4/10/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "phraseController.h"


@implementation phraseController
-(id)init
{
	self = [super init];
	
	backButton = [[GLButton alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
	backButton._delegate = self;
	[backButton setTitle:@"back"];
	[self addSubview:backButton];

	phraseSet = [[NSMutableArray alloc] initWithCapacity:0];
//	for(int i=0; i<
	return self;
}
-(void)buttonDidPress:(GLButton *)_button
{
	if(backButton == _button){
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"switchToMenu" object:self];
	}
}	
-(void)render
{
	[super render];
}

@end
