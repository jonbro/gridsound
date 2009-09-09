//
//  phrase_controller.mm
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 4/10/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import "phraseController.h"


@implementation phraseController

@synthesize loading;

-(id)init
{
	self = [super init];
	
	backButton = [[GLButton alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
	backButton._delegate = self;
	[backButton setTitle:@"back"];
	[self addSubview:backButton];

	phraseSet = [[NSMutableArray alloc] initWithCapacity:0];
	
	clearPhrase = [[GLButton alloc] initWithFrame:CGRectMake(10, 50, 200, 40)];
	clearPhrase._delegate = self;
	[clearPhrase setTitle:@"CLEAR"];
	[self addSubview:clearPhrase];
	
	loading = true;
	
//	for(int i=0; i<
	return self;
}
-(void)buttonDidPress:(GLButton *)_button
{
	if(backButton == _button){
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"switchToMenu" object:self];
	}
	if(loading){
		if(_button == clearPhrase){
			parentModel *pModel = [bankC loadParent:0];
			if(pModel != nil){
				[parentC setModel:pModel];
			}
		}
	}else{
		[bankC saveParent:parentC.model atIndex:0];
	}
}
-(void)setBankController:(bankController*)_bankC
{
	[bankC release];
	bankC = [_bankC retain];
	
}
-(void)setParentController:(parentController*)_parentC
{
	[parentC release];
	parentC = [_parentC retain];
}
-(void)render
{
	[super render];
}

@end
