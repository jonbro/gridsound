//
//  mainController.mm
//  mujik
//
//  Created by jonbroFERrealz on 8/30/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "mainController.h"


@implementation mainController
@synthesize parentC, bankC;

-(id)init
{
	self = [super init];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(switchToBank:)
												 name:@"switchToBank" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(switchToMain:)
												 name:@"switchToMain" object:nil];
	
	
	return self;
}
-(void)switchToBank:(NSNotification *)notification
{
	[self removeSubview:parentC];
	[self addSubview:bankC];
}
-(void)switchToMain:(NSNotification *)notification
{
	[self removeSubview:bankC];
	[self addSubview:parentC];
}
@end
